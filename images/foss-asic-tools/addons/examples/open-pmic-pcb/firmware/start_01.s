# SPDX-FileCopyrightText: 2020 Efabless Corporation
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

.section .text

start:

la x2, 0x21000000
li x1, 1
sw x1, 0(x2)   # LED off
sw x0, 4(x2)
sw x0, 8(x2)
sw x0, 12(x2)

#flash:
#sw x1, 0(x2)

#sw x0, 0(x2)
#beq x0, x0, flash

#flash:
#sw x0, 0(x2)
#call delay
#sw x1, 0(x2)
#call delay
#beq x0, x0, flash

flash:

sw x0, 0(x2)  # LED on
#li x11, 100
#dloop2:
li x10, 500
dloop:
addi x10, x10, -1
bne x10, x0, dloop
#addi x11, x11, -1
#bne x11, x0, dloop2

sw x1, 0(x2)  # LED off
#li x11, 100
#dloop4:
li x10, 500
dloop3:
addi x10, x10, -1
bne x10, x0, dloop3
#addi x11, x11, -1
#bne x11, x0, dloop4

sw x0, 0(x2)  # LED on

done:
beq x0, x0, done

#delay:
#li x11, 5
#dloop2:
#li x10, 4000
#dloop:
#addi x10, x10, -1
#bne x10, x0, dloop
#addi x11, x11, -1
#bne x11, x0, dloop2
#ret

# zero-initialize register file
#addi x1, zero, 0
# x2 (sp) is initialized by reset
#addi x3, zero, 0
#addi x4, zero, 0
#addi x5, zero, 0
#addi x6, zero, 0
#addi x7, zero, 0
#addi x8, zero, 0
#addi x9, zero, 0
#addi x10, zero, 0
#addi x11, zero, 0
#addi x12, zero, 0
#addi x13, zero, 0
#addi x14, zero, 0
#addi x15, zero, 0
#addi x16, zero, 0
#addi x17, zero, 0
#addi x18, zero, 0
#addi x19, zero, 0
#addi x20, zero, 0
#addi x21, zero, 0
#addi x22, zero, 0
#addi x23, zero, 0
#addi x24, zero, 0
#addi x25, zero, 0
#addi x26, zero, 0
#addi x27, zero, 0
#addi x28, zero, 0
#addi x29, zero, 0
#addi x30, zero, 0
#addi x31, zero, 0

# zero initialize scratchpad memory
# setmemloop:
# sw zero, 0(x1)
# addi x1, x1, 4
# blt x1, sp, setmemloop

# copy data section
#la a0, _sidata
#la a1, _sdata
#la a2, _edata
#bge a1, a2, end_init_data
#loop_init_data:
#lw a3, 0(a0)
#sw a3, 0(a1)
#addi a0, a0, 4
#addi a1, a1, 4
#blt a1, a2, loop_init_data
#end_init_data:

# zero-init bss section
#la a0, _sbss
#la a1, _ebss
#bge a0, a1, end_init_bss
#loop_init_bss:
#sw zero, 0(a0)
#addi a0, a0, 4
#blt a0, a1, loop_init_bss
#end_init_bss:

# call main
call main
#loop:
#j loop


