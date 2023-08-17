/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'intel_niosv_m_0' in SOPC Builder design 'soc_system'
 * SOPC Builder design path: /home/tyler/PL-Sensor-Intel/EXPERIMENTS/quartus_projects/niosv_aes/soc_system.sopcinfo
 *
 * Generated: Wed Aug 16 16:33:44 PDT 2023
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

#define ALT_CPU_ARCHITECTURE "intel_niosv_m"
#define ALT_CPU_CPU_FREQ 25000000u
#define ALT_CPU_DATA_ADDR_WIDTH 0x20
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_FREQ 25000000
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x20
#define ALT_CPU_MTIME_OFFSET 0x00010000
#define ALT_CPU_NAME "intel_niosv_m_0"
#define ALT_CPU_NUM_GPR 32
#define ALT_CPU_RESET_ADDR 0x00000000
#define ALT_CPU_TICKS_PER_SEC NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND
#define ALT_CPU_TIMER_DEVICE_TYPE 2


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define ABBOTTSLAKE_CPU_FREQ 25000000u
#define ABBOTTSLAKE_DATA_ADDR_WIDTH 0x20
#define ABBOTTSLAKE_DCACHE_LINE_SIZE 0
#define ABBOTTSLAKE_DCACHE_LINE_SIZE_LOG2 0
#define ABBOTTSLAKE_DCACHE_SIZE 0
#define ABBOTTSLAKE_ICACHE_LINE_SIZE 0
#define ABBOTTSLAKE_ICACHE_LINE_SIZE_LOG2 0
#define ABBOTTSLAKE_ICACHE_SIZE 0
#define ABBOTTSLAKE_INST_ADDR_WIDTH 0x20
#define ABBOTTSLAKE_MTIME_OFFSET 0x00010000
#define ABBOTTSLAKE_NUM_GPR 32
#define ABBOTTSLAKE_RESET_ADDR 0x00000000
#define ABBOTTSLAKE_TICKS_PER_SEC NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND
#define ABBOTTSLAKE_TIMER_DEVICE_TYPE 2


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __INTEL_NIOSV_M


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/null"
#define ALT_STDERR_BASE 0x0
#define ALT_STDERR_DEV null
#define ALT_STDERR_TYPE ""
#define ALT_STDIN "/dev/null"
#define ALT_STDIN_BASE 0x0
#define ALT_STDIN_DEV null
#define ALT_STDIN_TYPE ""
#define ALT_STDOUT "/dev/null"
#define ALT_STDOUT_BASE 0x0
#define ALT_STDOUT_DEV null
#define ALT_STDOUT_TYPE ""
#define ALT_SYSTEM_NAME "soc_system"
#define ALT_SYS_CLK_TICKS_PER_SEC ALT_CPU_TICKS_PER_SEC
#define ALT_TIMESTAMP_CLK_TIMER_DEVICE_TYPE ALT_CPU_TIMER_DEVICE_TYPE


/*
 * hal2 configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK INTEL_NIOSV_M_0
#define ALT_TIMESTAMP_CLK INTEL_NIOSV_M_0


/*
 * intel_niosv_m_0 configuration
 *
 */

#define ALT_MODULE_CLASS_intel_niosv_m_0 intel_niosv_m
#define INTEL_NIOSV_M_0_BASE 0x10000
#define INTEL_NIOSV_M_0_CPU_FREQ 25000000u
#define INTEL_NIOSV_M_0_DATA_ADDR_WIDTH 0x20
#define INTEL_NIOSV_M_0_DCACHE_LINE_SIZE 0
#define INTEL_NIOSV_M_0_DCACHE_LINE_SIZE_LOG2 0
#define INTEL_NIOSV_M_0_DCACHE_SIZE 0
#define INTEL_NIOSV_M_0_ICACHE_LINE_SIZE 0
#define INTEL_NIOSV_M_0_ICACHE_LINE_SIZE_LOG2 0
#define INTEL_NIOSV_M_0_ICACHE_SIZE 0
#define INTEL_NIOSV_M_0_INST_ADDR_WIDTH 0x20
#define INTEL_NIOSV_M_0_INTERRUPT_CONTROLLER_ID 0
#define INTEL_NIOSV_M_0_IRQ -1
#define INTEL_NIOSV_M_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define INTEL_NIOSV_M_0_MTIME_OFFSET 0x00010000
#define INTEL_NIOSV_M_0_NAME "/dev/intel_niosv_m_0"
#define INTEL_NIOSV_M_0_NUM_GPR 32
#define INTEL_NIOSV_M_0_RESET_ADDR 0x00000000
#define INTEL_NIOSV_M_0_SPAN 64
#define INTEL_NIOSV_M_0_TICKS_PER_SEC NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND
#define INTEL_NIOSV_M_0_TIMER_DEVICE_TYPE 2
#define INTEL_NIOSV_M_0_TYPE "intel_niosv_m"


/*
 * intel_niosv_m_hal_driver configuration
 *
 */

#define NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND 1000


/*
 * nios_v_ram configuration
 *
 */

#define ALT_MODULE_CLASS_nios_v_ram altera_avalon_onchip_memory2
#define NIOS_V_RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define NIOS_V_RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define NIOS_V_RAM_BASE 0x0
#define NIOS_V_RAM_CONTENTS_INFO ""
#define NIOS_V_RAM_DUAL_PORT 0
#define NIOS_V_RAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define NIOS_V_RAM_INIT_CONTENTS_FILE "soc_system_nios_v_ram"
#define NIOS_V_RAM_INIT_MEM_CONTENT 1
#define NIOS_V_RAM_INSTANCE_ID "NONE"
#define NIOS_V_RAM_IRQ -1
#define NIOS_V_RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS_V_RAM_NAME "/dev/nios_v_ram"
#define NIOS_V_RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define NIOS_V_RAM_RAM_BLOCK_TYPE "AUTO"
#define NIOS_V_RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define NIOS_V_RAM_SINGLE_CLOCK_OP 0
#define NIOS_V_RAM_SIZE_MULTIPLE 1
#define NIOS_V_RAM_SIZE_VALUE 32768
#define NIOS_V_RAM_SPAN 32768
#define NIOS_V_RAM_TYPE "altera_avalon_onchip_memory2"
#define NIOS_V_RAM_WRITABLE 1


/*
 * peripheral_mem configuration
 *
 */

#define ALT_MODULE_CLASS_peripheral_mem altera_avalon_onchip_memory2
#define PERIPHERAL_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define PERIPHERAL_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define PERIPHERAL_MEM_BASE 0x8000
#define PERIPHERAL_MEM_CONTENTS_INFO ""
#define PERIPHERAL_MEM_DUAL_PORT 1
#define PERIPHERAL_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define PERIPHERAL_MEM_INIT_CONTENTS_FILE "soc_system_peripheral_mem"
#define PERIPHERAL_MEM_INIT_MEM_CONTENT 1
#define PERIPHERAL_MEM_INSTANCE_ID "NONE"
#define PERIPHERAL_MEM_IRQ -1
#define PERIPHERAL_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PERIPHERAL_MEM_NAME "/dev/peripheral_mem"
#define PERIPHERAL_MEM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define PERIPHERAL_MEM_RAM_BLOCK_TYPE "AUTO"
#define PERIPHERAL_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define PERIPHERAL_MEM_SINGLE_CLOCK_OP 0
#define PERIPHERAL_MEM_SIZE_MULTIPLE 1
#define PERIPHERAL_MEM_SIZE_VALUE 512
#define PERIPHERAL_MEM_SPAN 512
#define PERIPHERAL_MEM_TYPE "altera_avalon_onchip_memory2"
#define PERIPHERAL_MEM_WRITABLE 1

#endif /* __SYSTEM_H_ */
