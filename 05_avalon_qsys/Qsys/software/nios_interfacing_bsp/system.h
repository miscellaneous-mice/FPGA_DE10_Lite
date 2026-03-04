/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'NIOS_II' in SOPC Builder design 'avalon_design'
 * SOPC Builder design path: ../../avalon_design.sopcinfo
 *
 * Generated: Wed Mar 04 19:51:09 IST 2026
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
#define ALT_CPU_BREAK_ADDR 0x00040820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x13
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x00020020
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
#define ALT_CPU_INST_ADDR_WIDTH 0x13
#define ALT_CPU_NAME "NIOS_II"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00020000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00040820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x13
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x00020020
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
#define NIOS2_INST_ADDR_WIDTH 0x13
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00020000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2
#define __AVALON_COUNTER_INTERFACE
#define __AVALON_HEX_PIO


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
#define ALT_STDERR "/dev/mem_sys_subsystem_DEBUG"
#define ALT_STDERR_BASE 0x41408
#define ALT_STDERR_DEV mem_sys_subsystem_DEBUG
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/mem_sys_subsystem_DEBUG"
#define ALT_STDIN_BASE 0x41408
#define ALT_STDIN_DEV mem_sys_subsystem_DEBUG
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/mem_sys_subsystem_DEBUG"
#define ALT_STDOUT_BASE 0x41408
#define ALT_STDOUT_DEV mem_sys_subsystem_DEBUG
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "avalon_design"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * io_peripherals_button_pio configuration
 *
 */

#define ALT_MODULE_CLASS_io_peripherals_button_pio altera_avalon_pio
#define IO_PERIPHERALS_BUTTON_PIO_BASE 0x41000
#define IO_PERIPHERALS_BUTTON_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define IO_PERIPHERALS_BUTTON_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define IO_PERIPHERALS_BUTTON_PIO_CAPTURE 0
#define IO_PERIPHERALS_BUTTON_PIO_DATA_WIDTH 2
#define IO_PERIPHERALS_BUTTON_PIO_DO_TEST_BENCH_WIRING 0
#define IO_PERIPHERALS_BUTTON_PIO_DRIVEN_SIM_VALUE 0
#define IO_PERIPHERALS_BUTTON_PIO_EDGE_TYPE "NONE"
#define IO_PERIPHERALS_BUTTON_PIO_FREQ 50000000
#define IO_PERIPHERALS_BUTTON_PIO_HAS_IN 1
#define IO_PERIPHERALS_BUTTON_PIO_HAS_OUT 0
#define IO_PERIPHERALS_BUTTON_PIO_HAS_TRI 0
#define IO_PERIPHERALS_BUTTON_PIO_IRQ -1
#define IO_PERIPHERALS_BUTTON_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_PERIPHERALS_BUTTON_PIO_IRQ_TYPE "NONE"
#define IO_PERIPHERALS_BUTTON_PIO_NAME "/dev/io_peripherals_button_pio"
#define IO_PERIPHERALS_BUTTON_PIO_RESET_VALUE 0
#define IO_PERIPHERALS_BUTTON_PIO_SPAN 16
#define IO_PERIPHERALS_BUTTON_PIO_TYPE "altera_avalon_pio"


/*
 * io_peripherals_counter configuration
 *
 */

#define ALT_MODULE_CLASS_io_peripherals_counter avalon_counter_interface
#define IO_PERIPHERALS_COUNTER_BASE 0x41020
#define IO_PERIPHERALS_COUNTER_IRQ -1
#define IO_PERIPHERALS_COUNTER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_PERIPHERALS_COUNTER_NAME "/dev/io_peripherals_counter"
#define IO_PERIPHERALS_COUNTER_SPAN 16
#define IO_PERIPHERALS_COUNTER_TYPE "avalon_counter_interface"


/*
 * io_peripherals_hex_display configuration
 *
 */

#define ALT_MODULE_CLASS_io_peripherals_hex_display avalon_hex_pio
#define IO_PERIPHERALS_HEX_DISPLAY_BASE 0x41030
#define IO_PERIPHERALS_HEX_DISPLAY_IRQ -1
#define IO_PERIPHERALS_HEX_DISPLAY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_PERIPHERALS_HEX_DISPLAY_NAME "/dev/io_peripherals_hex_display"
#define IO_PERIPHERALS_HEX_DISPLAY_SPAN 8
#define IO_PERIPHERALS_HEX_DISPLAY_TYPE "avalon_hex_pio"


/*
 * io_peripherals_led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_io_peripherals_led_pio altera_avalon_pio
#define IO_PERIPHERALS_LED_PIO_BASE 0x41010
#define IO_PERIPHERALS_LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define IO_PERIPHERALS_LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define IO_PERIPHERALS_LED_PIO_CAPTURE 0
#define IO_PERIPHERALS_LED_PIO_DATA_WIDTH 1
#define IO_PERIPHERALS_LED_PIO_DO_TEST_BENCH_WIRING 0
#define IO_PERIPHERALS_LED_PIO_DRIVEN_SIM_VALUE 0
#define IO_PERIPHERALS_LED_PIO_EDGE_TYPE "NONE"
#define IO_PERIPHERALS_LED_PIO_FREQ 50000000
#define IO_PERIPHERALS_LED_PIO_HAS_IN 0
#define IO_PERIPHERALS_LED_PIO_HAS_OUT 1
#define IO_PERIPHERALS_LED_PIO_HAS_TRI 0
#define IO_PERIPHERALS_LED_PIO_IRQ -1
#define IO_PERIPHERALS_LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_PERIPHERALS_LED_PIO_IRQ_TYPE "NONE"
#define IO_PERIPHERALS_LED_PIO_NAME "/dev/io_peripherals_led_pio"
#define IO_PERIPHERALS_LED_PIO_RESET_VALUE 0
#define IO_PERIPHERALS_LED_PIO_SPAN 16
#define IO_PERIPHERALS_LED_PIO_TYPE "altera_avalon_pio"


/*
 * mem_sys_subsystem_DEBUG configuration
 *
 */

#define ALT_MODULE_CLASS_mem_sys_subsystem_DEBUG altera_avalon_jtag_uart
#define MEM_SYS_SUBSYSTEM_DEBUG_BASE 0x41408
#define MEM_SYS_SUBSYSTEM_DEBUG_IRQ 0
#define MEM_SYS_SUBSYSTEM_DEBUG_IRQ_INTERRUPT_CONTROLLER_ID 0
#define MEM_SYS_SUBSYSTEM_DEBUG_NAME "/dev/mem_sys_subsystem_DEBUG"
#define MEM_SYS_SUBSYSTEM_DEBUG_READ_DEPTH 64
#define MEM_SYS_SUBSYSTEM_DEBUG_READ_THRESHOLD 8
#define MEM_SYS_SUBSYSTEM_DEBUG_SPAN 8
#define MEM_SYS_SUBSYSTEM_DEBUG_TYPE "altera_avalon_jtag_uart"
#define MEM_SYS_SUBSYSTEM_DEBUG_WRITE_DEPTH 64
#define MEM_SYS_SUBSYSTEM_DEBUG_WRITE_THRESHOLD 8


/*
 * mem_sys_subsystem_SRAM configuration
 *
 */

#define ALT_MODULE_CLASS_mem_sys_subsystem_SRAM altera_avalon_onchip_memory2
#define MEM_SYS_SUBSYSTEM_SRAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define MEM_SYS_SUBSYSTEM_SRAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define MEM_SYS_SUBSYSTEM_SRAM_BASE 0x20000
#define MEM_SYS_SUBSYSTEM_SRAM_CONTENTS_INFO ""
#define MEM_SYS_SUBSYSTEM_SRAM_DUAL_PORT 0
#define MEM_SYS_SUBSYSTEM_SRAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define MEM_SYS_SUBSYSTEM_SRAM_INIT_CONTENTS_FILE "avalon_design_mem_sys_subsystem_SRAM"
#define MEM_SYS_SUBSYSTEM_SRAM_INIT_MEM_CONTENT 0
#define MEM_SYS_SUBSYSTEM_SRAM_INSTANCE_ID "NONE"
#define MEM_SYS_SUBSYSTEM_SRAM_IRQ -1
#define MEM_SYS_SUBSYSTEM_SRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MEM_SYS_SUBSYSTEM_SRAM_NAME "/dev/mem_sys_subsystem_SRAM"
#define MEM_SYS_SUBSYSTEM_SRAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define MEM_SYS_SUBSYSTEM_SRAM_RAM_BLOCK_TYPE "AUTO"
#define MEM_SYS_SUBSYSTEM_SRAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define MEM_SYS_SUBSYSTEM_SRAM_SINGLE_CLOCK_OP 0
#define MEM_SYS_SUBSYSTEM_SRAM_SIZE_MULTIPLE 1
#define MEM_SYS_SUBSYSTEM_SRAM_SIZE_VALUE 131072
#define MEM_SYS_SUBSYSTEM_SRAM_SPAN 131072
#define MEM_SYS_SUBSYSTEM_SRAM_TYPE "altera_avalon_onchip_memory2"
#define MEM_SYS_SUBSYSTEM_SRAM_WRITABLE 1


/*
 * mem_sys_subsystem_SYS_ID configuration
 *
 */

#define ALT_MODULE_CLASS_mem_sys_subsystem_SYS_ID altera_avalon_sysid_qsys
#define MEM_SYS_SUBSYSTEM_SYS_ID_BASE 0x41400
#define MEM_SYS_SUBSYSTEM_SYS_ID_ID 0
#define MEM_SYS_SUBSYSTEM_SYS_ID_IRQ -1
#define MEM_SYS_SUBSYSTEM_SYS_ID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MEM_SYS_SUBSYSTEM_SYS_ID_NAME "/dev/mem_sys_subsystem_SYS_ID"
#define MEM_SYS_SUBSYSTEM_SYS_ID_SPAN 8
#define MEM_SYS_SUBSYSTEM_SYS_ID_TIMESTAMP 1772633514
#define MEM_SYS_SUBSYSTEM_SYS_ID_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
