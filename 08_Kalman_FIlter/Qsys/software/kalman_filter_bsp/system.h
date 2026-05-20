/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'NIOS' in SOPC Builder design 'kalman_interface'
 * SOPC Builder design path: ../../kalman_interface.sopcinfo
 *
 * Generated: Thu May 21 01:08:49 IST 2026
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x08200820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1c
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x04000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1c
#define ALT_CPU_NAME "NIOS"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x04000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x08200820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1c
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x04000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1c
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x04000000


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_FPU(n,A,B) __builtin_custom_inii(ALT_CI_FPU_N+(n&ALT_CI_FPU_N_MASK),(A),(B))
#define ALT_CI_FPU_N 0xfc
#define ALT_CI_FPU_N_MASK ((1<<2)-1)


/*
 * DEBUG configuration
 *
 */

#define ALT_MODULE_CLASS_DEBUG altera_avalon_jtag_uart
#define DEBUG_BASE 0x8201090
#define DEBUG_IRQ 0
#define DEBUG_IRQ_INTERRUPT_CONTROLLER_ID 0
#define DEBUG_NAME "/dev/DEBUG"
#define DEBUG_READ_DEPTH 64
#define DEBUG_READ_THRESHOLD 8
#define DEBUG_SPAN 8
#define DEBUG_TYPE "altera_avalon_jtag_uart"
#define DEBUG_WRITE_DEPTH 64
#define DEBUG_WRITE_THRESHOLD 8


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2
#define __ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT
#define __ALTERA_ONCHIP_FLASH
#define __KALMAN_FILTER


/*
 * FLASH_MEM_csr configuration
 *
 */

#define ALT_MODULE_CLASS_FLASH_MEM_csr altera_onchip_flash
#define FLASH_MEM_CSR_BASE 0x8201080
#define FLASH_MEM_CSR_BYTES_PER_PAGE 8192
#define FLASH_MEM_CSR_IRQ -1
#define FLASH_MEM_CSR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FLASH_MEM_CSR_NAME "/dev/FLASH_MEM_csr"
#define FLASH_MEM_CSR_READ_ONLY_MODE 0
#define FLASH_MEM_CSR_SECTOR1_ENABLED 1
#define FLASH_MEM_CSR_SECTOR1_END_ADDR 0x7fff
#define FLASH_MEM_CSR_SECTOR1_START_ADDR 0
#define FLASH_MEM_CSR_SECTOR2_ENABLED 1
#define FLASH_MEM_CSR_SECTOR2_END_ADDR 0xffff
#define FLASH_MEM_CSR_SECTOR2_START_ADDR 0x8000
#define FLASH_MEM_CSR_SECTOR3_ENABLED 1
#define FLASH_MEM_CSR_SECTOR3_END_ADDR 0x6ffff
#define FLASH_MEM_CSR_SECTOR3_START_ADDR 0x10000
#define FLASH_MEM_CSR_SECTOR4_ENABLED 1
#define FLASH_MEM_CSR_SECTOR4_END_ADDR 0xb7fff
#define FLASH_MEM_CSR_SECTOR4_START_ADDR 0x70000
#define FLASH_MEM_CSR_SECTOR5_ENABLED 1
#define FLASH_MEM_CSR_SECTOR5_END_ADDR 0x15ffff
#define FLASH_MEM_CSR_SECTOR5_START_ADDR 0xb8000
#define FLASH_MEM_CSR_SPAN 8
#define FLASH_MEM_CSR_TYPE "altera_onchip_flash"


/*
 * FLASH_MEM_data configuration
 *
 */

#define ALT_MODULE_CLASS_FLASH_MEM_data altera_onchip_flash
#define FLASH_MEM_DATA_BASE 0x8000000
#define FLASH_MEM_DATA_BYTES_PER_PAGE 8192
#define FLASH_MEM_DATA_IRQ -1
#define FLASH_MEM_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FLASH_MEM_DATA_NAME "/dev/FLASH_MEM_data"
#define FLASH_MEM_DATA_READ_ONLY_MODE 0
#define FLASH_MEM_DATA_SECTOR1_ENABLED 1
#define FLASH_MEM_DATA_SECTOR1_END_ADDR 0x7fff
#define FLASH_MEM_DATA_SECTOR1_START_ADDR 0
#define FLASH_MEM_DATA_SECTOR2_ENABLED 1
#define FLASH_MEM_DATA_SECTOR2_END_ADDR 0xffff
#define FLASH_MEM_DATA_SECTOR2_START_ADDR 0x8000
#define FLASH_MEM_DATA_SECTOR3_ENABLED 1
#define FLASH_MEM_DATA_SECTOR3_END_ADDR 0x6ffff
#define FLASH_MEM_DATA_SECTOR3_START_ADDR 0x10000
#define FLASH_MEM_DATA_SECTOR4_ENABLED 1
#define FLASH_MEM_DATA_SECTOR4_END_ADDR 0xb7fff
#define FLASH_MEM_DATA_SECTOR4_START_ADDR 0x70000
#define FLASH_MEM_DATA_SECTOR5_ENABLED 1
#define FLASH_MEM_DATA_SECTOR5_END_ADDR 0x15ffff
#define FLASH_MEM_DATA_SECTOR5_START_ADDR 0xb8000
#define FLASH_MEM_DATA_SPAN 1441792
#define FLASH_MEM_DATA_TYPE "altera_onchip_flash"


/*
 * KALMAN configuration
 *
 */

#define ALT_MODULE_CLASS_KALMAN kalman_filter
#define KALMAN_BASE 0x8201000
#define KALMAN_IRQ -1
#define KALMAN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define KALMAN_NAME "/dev/KALMAN"
#define KALMAN_SPAN 128
#define KALMAN_TYPE "kalman_filter"


/*
 * SDRAM configuration
 *
 */

#define ALT_MODULE_CLASS_SDRAM altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x4000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/SDRAM"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 67108864
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * SYS_ID configuration
 *
 */

#define ALT_MODULE_CLASS_SYS_ID altera_avalon_sysid_qsys
#define SYS_ID_BASE 0x8201088
#define SYS_ID_ID 0
#define SYS_ID_IRQ -1
#define SYS_ID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYS_ID_NAME "/dev/SYS_ID"
#define SYS_ID_SPAN 8
#define SYS_ID_TIMESTAMP 1779304945
#define SYS_ID_TYPE "altera_avalon_sysid_qsys"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "MAX 10"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/DEBUG"
#define ALT_STDERR_BASE 0x8201090
#define ALT_STDERR_DEV DEBUG
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/DEBUG"
#define ALT_STDIN_BASE 0x8201090
#define ALT_STDIN_DEV DEBUG
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/DEBUG"
#define ALT_STDOUT_BASE 0x8201090
#define ALT_STDOUT_DEV DEBUG
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "kalman_interface"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

#endif /* __SYSTEM_H_ */
