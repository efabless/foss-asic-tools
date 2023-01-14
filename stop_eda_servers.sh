#!/bin/bash
# ========================================================================
# Stops and removes multiple IIC-OSIC-TOOLS containers for many EDA users
#
# SPDX-FileCopyrightText: 2023 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
# ========================================================================

DEBUG=0

while getopts "hd" flag; do
	case $flag in
		d)
			echo "[INFO] DEBUG is enabled"
			DEBUG=1
			;;
		h)
			echo
			echo "Stopping Docker instances for EDA users (IIC@JKU)"
			echo
			echo "Usage: $0 [-h] [-d]"
			echo
			echo "       -h shows a help screen"
			echo "       -d enables the debug mode"
			echo 
			exit
			;;
		*)
			;;
    esac
done
shift $((OPTIND-1))

# now search the containers and remove them
echo "[INFO] Stopping and removing EDA containers."
NO_INSTANCES=0
while [ "$(docker ps -q -f name="iic-osic-tools_eda_user")" ];
do
	CONTAINER_ID=$(docker ps -q -f name="iic-osic-tools_eda_user" | head -n1)
	[ $DEBUG = 1 ] && echo "[INFO] Container ID $CONTAINER_ID found, now stopping and removing!"
	docker stop "$CONTAINER_ID" > /dev/null
	docker rm "$CONTAINER_ID" > /dev/null
	NO_INSTANCES=$((NO_INSTANCES + 1))
	echo "[INFO] Container nr. $NO_INSTANCES stopped and removed."
done	

echo "[INFO] All EDA containers have been stopped and removed!"
echo "[DONE] Bye!"
