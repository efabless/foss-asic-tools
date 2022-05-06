<!---
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
-->

# Simulation Environment Setup

There are two options for setting up the simulation environment: 

* Pulling a pre-built docker image 
* Installing the dependecies locally

## 1. Docker

There is an available docker setup with the needed tools at [efabless/dockerized-verification-setup](https://github.com/efabless/dockerized-verification-setup) 

Run the following to pull the image: 

```
docker pull efabless/dv_setup:latest
```

## 2. Local Installion (Linux)

You will need to fullfil these dependecies: 

* Icarus Verilog (10.2+)
* RV32I Toolchain

Using apt, you can install Icarus Verilog:

```bash
sudo apt-get install iverilog
```

Next, you will need to build the RV32I toolchain. Firstly, export the installation path for the RV32I toolchain, 

```bash
export GCC_PATH=<gcc-installation-path>
```

Then, run the following: 

```bash
# packages needed:
sudo apt-get install autoconf automake autotools-dev curl libmpc-dev \
    libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo \
    gperf libtool patchutils bc zlib1g-dev git libexpat1-dev

sudo mkdir $GCC_PATH
sudo chown $USER $GCC_PATH

git clone https://github.com/riscv/riscv-gnu-toolchain riscv-gnu-toolchain-rv32i
cd riscv-gnu-toolchain-rv32i
git checkout 411d134
git submodule update --init --recursive

mkdir build; cd build
../configure --with-arch=rv32i --prefix=$GCC_PATH
make -j$(nproc)
```

# Running Simulation

## Docker

First, you will need to export a number of environment variables: 

```bash
export PDK_PATH=<pdk-location/sky130A>
export CARAVEL_ROOT=<caravel_root>
export UPRJ_ROOT=<user_project_root>
```

Then, run the following command to start the docker container :

```
docker run -it -v $CARAVEL_ROOT:$CARAVEL_ROOT -v $PDK_PATH:$PDK_PATH -v $UPRJ_ROOT:$UPRJ_ROOT -e CARAVEL_ROOT=$CARAVEL_ROOT -e PDK_PATH=$PDK_PATH -e UPRJ_ROOT=$UPRJ_ROOT -u $(id -u $USER):$(id -g $USER) efabless/dv_setup:latest
```

Then, navigate to the directory where the DV tests reside : 

```bash
cd $UPRJ_ROOT/verilog/dv/
```

Then, follow the instructions at [Both](#both) to run RTL/GL simulation.

## Local

You will need to export these environment variables: 

```bash
export GCC_PATH=<gcc-installation-path>
export PDK_PATH=<pdk-location/sky130A>
```

Then, follow the instruction at [Both](#both) to run RTL/GL simulation.

## Both

To run RTL simulation for one of the DV tests, 

```bash
cd <dv-test>
make
```

To run gate level simulation for one of the DV tests, 

```bash
cd <dv-test>
SIM=GL make
```

# User Analog Project Example DV

> :construction: Under construction :construction:
