/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include "verilog/dv/caravel/defs.h"

// --------------------------------------------------------

void main()
{
    reg_spimaster_config = 0xa002;	// Enable, prescaler = 2

    reg_mprj_datal = 0x00000000;
    reg_mprj_datah = 0x00000000;

    // Configure mprj_io 10 and 25 as analog (digital in/out = off)
    // Configure mprj_io 11, 12, 26, and 27 as digital output
    // mprj_io 14 to 24 are analog pads and cannot be configured

    reg_mprj_io_27 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_26 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_25 = GPIO_MODE_USER_STD_ANALOG;

    reg_mprj_io_12 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_11 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_10 = GPIO_MODE_USER_STD_ANALOG;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    /* Block until end of test */
    while (1);
}

