.. raw:: html

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

Caravel Analog User Project
===========================

|License| |User CI| |Caravan Build|

Table of contents
=================

-  `Overview <#overview>`__
-  `Install Caravel <#install-caravel>`__
-  `Caravel Integration <#caravel-integration>`__

   - `User Project: Power on Reset <#user-project-power-on-reset>`_
   -  `Verilog Integration <#verilog-integration>`__
   
-  `Running Full Chip Simulation <#running-full-chip-simulation>`__
-  `Analog Design Flow <#analog-design-flow>`__
- `Other Miscellaneous Targets <#other-miscellaneous-targets>`_
-  `Checklist for Open-MPW
   Submission <#checklist-for-open-mpw-submission>`__
   
Overview
========

This repo contains a sample user project that utilizes the caravan chip (analog version of `caravel <https://github.com/efabless/caravel.git>`__) user space. The user project is a simple power-on-reset that showcases how to make use of caravan's user space utilities like IO pads, logic analyzer probes, and wishbone port. The repo also demonstrates the recommended structure for the open-mpw **analog** projects.

Install Caravel
===============

To setup caravel, run the following:

.. code:: bash

    # By default, CARAVEL_ROOT is set to $(pwd)/caravel
    # If you want to install caravel at a different location, run "export CARAVEL_ROOT=<caravel-path>"
    # Disable submodule installation if needed by, run "export SUBMODULE=0"
    
    git clone https://github.com/efabless/caravel_user_project_analog.git
    cd caravel_user_project_analog
    make install

To update the installed caravel to the latest, run:

.. code:: bash

     make update_caravel

To remove caravel, run

.. code:: bash

    make uninstall

By default
`caravel-lite <https://github.com/efabless/caravel-lite.git>`__ is
installed. To install the full version of caravel, run this prior to
calling make install.

.. code:: bash

    export CARAVEL_LITE=0
 
Caravel Integration
=====================


User Project: Power on Reset
----------------------------

This is an example user analog project which breaks out the power-on-reset
circuit used by the management SoC for power-up behavior so that the circuit
input and output can be independently controlled and measured.

The power-on-reset circuit itself is a simple, non-temperature-compensated
analog delay calibrated to 15ms under nominal conditions, with a Schmitt
trigger inverter to provide hysteresis around the trigger point to provide
a clean output reset signal. 

The circuit provides a single high-voltage (3.3V domain) sense-inverted reset
signal "porb_h" and complementary low-voltage (1.8V domain) reset signals
"por_l" and "porb_l".

The only input to the circuit is the 3.3V domain power supply itself.


Verilog Integration
-------------------

You need to create a wrapper around your macro that adheres to the
template at
`user\_analog_project\_wrapper <https://github.com/efabless/caravel/blob/master/verilog/rtl/__user_analog_project_wrapper.v>`__.
The wrapper top module must be named ``user_analog_project_wrapper`` and must
have the same input and output ports as the analog wrapper template. The wrapper gives access to the
user space utilities provided by caravel like IO ports, logic analyzer
probes, and wishbone bus connection to the management SoC.

The verilog modules instantiated in the wrapper module should represent
the analog project;  they need not be more than empty blocks, but it is
encouraged to write a simple behavioral description of the analog circuit
in standard verilog, using real-valued wires when necessary.  This allows
the whole system to be run in a verilog testbench and verify the connectivity
to the padframe and management SoC, even if the testbench C code does nothing
more than set the mode of each GPIO pin.  The example top-level verilog code
emulates the behavior of the power-on-reset delay after applying a valid
power supply to the circuit.


Building the PDK 
================

You have two options for building the pdk: 

- Build the pdk natively. 

Make sure you have `Magic VLSI Layout Tool <http://opencircuitdesign.com/magic/index.html>`__   `version 8.3.160 <https://github.com/RTimothyEdwards/magic/tree/8.3.160>`__ installed on your machine before building the pdk. 

.. code:: bash

    # set PDK_ROOT to the path you wish to use for the pdk
    export PDK_ROOT=<pdk-installation-path>

    # you can optionally specify skywater-pdk and open-pdks commit used
    # by setting and exporting SKYWATER_COMMIT and OPEN_PDKS_COMMIT
    # if you do not set them, they default to the last verfied commits tested for this project

    make pdk

- Build the pdk using openlane's docker image which has magic installed. 

.. code:: bash

    # set PDK_ROOT to the path you wish to use for the pdk
    export PDK_ROOT=<pdk-installation-path>

    # you can optionally specify skywater-pdk and open-pdks commit used
    # by setting and exporting SKYWATER_COMMIT and OPEN_PDKS_COMMIT
    # if you do not set them, they default to the last verfied commits tested for this project

    make pdk-nonnative

Running Full Chip Simulation
============================

First, you will need to install the simulation environment, by

.. code:: bash

    make simenv

This will pull a docker image with the needed tools installed.

To install the simulation environment locally, refer to `README <https://github.com/efabless/caravel_user_project_analog/blob/main/verilog/dv/README.md>`__

Then, run the RTL and GL simulation by

.. code:: bash

    export PDK_ROOT=<pdk-installation-path>
    export CARAVEL_ROOT=$(pwd)/caravel
    # specify simulation mode: RTL/GL
    export SIM=RTL
    # Run the mprj_por testbench, make verify-mprj_por
    make verify-<testbench-name>

The verilog test-benches are under this directory
`verilog/dv <https://github.com/efabless/caravel_user_project_analog/tree/main/verilog/dv>`__.


Analog Design Flow
===================

The example project uses a very simple analog design flow with schematics
made with xschem, simulation done using ngspice, layout done with magic,
and LVS verification done with netgen.  Sources for the power-on-reset
circuit are in the "xschem/" directory, which also includes a schematic
representing the wrapper with all of its ports, for use in a testbench
circuit.  There are several testbenches in the example, starting from
tests of the component devices to a full test of the completed project
inside the wrapper.

There is no automation in this project;  the schematic and layout were
done by hand, including both the power-on-reset block and the power and
signal routing to the pins on the wrapper.

The power-on-reset circuit itself is simple and is not compensated for
temperature or voltage variation.  When the power supply reaches a
sufficient level, the voltage divider sets the gate voltage on an nFET
device to draw a current of nominally 240nA.  The testbench
"threshold_test_tb.spice" does a DC sweep to find the gate voltage that
produces this value.   Next, a cascaded current mirror divides down the
current by a factor of (roughly) 400.  The testbench current_test.spice
checks the current division value.  Finally, the output ~600pA from the
end of the current mirror is accumulated on a capacitor until the value
trips the input of the 3.3V Schmitt trigger buffer from the
sky130_fd_sd_hvl library.  The capacitor is sized to peg the nominal
time to trigger at 15ms.  The schematic "example_por_tb.sch" sets up
the testbench for this timing test.

The output of the Schmitt trigger buffer becomes the high-voltage
output, and is input to a standard buffer and inverter used as
level shifters from the 3.3V domain to the 1.8V domain, producing
complementary low-voltage outputs.

The user project is formed from two power-on-reset circuits, one of
which is connected to the user area VDDA1 power supply, and the other
of which is connected to one of the analog I/O pads, used as a power
supply input and connected to its voltage ESD clamp circuit.  The
3.3V domain outputs are connected directly to GPIO pads through the
ESD (150 ohm series) connection.  The 1.8V domain outputs are connected
to GPIO pads through the usual I/O connections, with the corresponding
user output enable (sense inverted) held low to keep the output always
active.

The C code testbench is in "verilog/dv/mprj_por/mprj_por.c" and only
sets the GPIO pins used to the correct state (user output function).
The POR circuit outputs are monitored by the testbench verilog file
"mprj_por_tb.v" which will fail if the connections are wrong or if
the behavioral POR verilog does not work as intended.

Note that to properly test this circuit, the GPIO pins have to be
configured for output to be seen and measured, implying that the
management SoC power supply must be stable and the C program running
off of the SPI flash before the user area power supplies are raised.


Running Open-MPW Precheck Locally
=================================

You can install the precheck by running 

.. code:: bash

   # By default, this install the precheck in your home directory
   # To change the installtion path, run "export PRECHECK_ROOT=<precheck installation path>" 
   make precheck

This will clone the precheck repo and pull the latest precheck docker image. 


Then, you can run the precheck by running
Specify CARAVEL_ROOT before running any of the following, 

.. code:: bash

   # export CARAVEL_ROOT=$(pwd)/caravel 
   export CARAVEL_ROOT=<path-to-caravel>
   make run-precheck

This will run all the precheck checks on your project and will retain the logs under the ``checks`` directory.

Other Miscellaneous Targets
============================

The makefile provides a number of useful that targets that can run compress, uncompress, and run XOR checks on your design. 

Compress gds files and any file larger than 100MB (GH file size limit), 

.. code:: bash

   make compress

Uncompress files, 

.. code:: bash

   make uncompress


Specify ``CARAVEL_ROOT`` before running any of the following, 

.. code:: bash

   # export CARAVEL_ROOT=$(pwd)/caravel 
   export CARAVEL_ROOT=<path-to-caravel>
   
Run XOR check, 

.. code:: bash

   make xor-analog-wrapper

Checklist for Open-MPW Submission
=================================


|:heavy_check_mark:| The project repo adheres to the same directory structure in this repo.
   
|:heavy_check_mark:| The project repo contain info.yaml at the project root.

|:heavy_check_mark:| Top level macro is named ``user_analog_project_wrapper``.

|:heavy_check_mark:| Full Chip Simulation passes for RTL and GL (gate-level)

|:heavy_check_mark:| The hardened Macros are LVS and DRC clean

|:heavy_check_mark:| The ``user_analog_project_wrapper`` adheres to empty wrapper template  order specified at  `user_analog_project_wrapper_empty <https://github.com/efabless/caravel/blob/master/mag/user_analog_project_wrapper_empty.mag>`__

|:heavy_check_mark:| XOR check passes with zero total difference.

|:heavy_check_mark:| Open-MPW-Precheck tool runs successfully. 


.. |License| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0
.. |User CI| image:: https://github.com/efabless/caravel_user_project_analog/actions/workflows/user_project_ci.yml/badge.svg
   :target: https://github.com/efabless/caravel_user_project_analog/actions/workflows/user_project_ci.yml
.. |Caravan Build| image:: https://github.com/efabless/caravel_user_project_analog/actions/workflows/caravan_build.yml/badge.svg
   :target: https://github.com/efabless/caravel_user_project_analog/actions/workflows/caravan_build.yml
