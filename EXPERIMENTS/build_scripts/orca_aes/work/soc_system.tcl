# qsys scripting (.tcl) file for soc_system
package require -exact qsys 16.0

create_system {soc_system}

set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE {5CSEBA6U23I7}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Instances and instance parameters
# (disabled instances are intentionally culled)
add_instance DMA_to_SDRAM altera_msgdma 22.1
set_instance_parameter_value DMA_to_SDRAM {BURST_ENABLE} {1}
set_instance_parameter_value DMA_to_SDRAM {BURST_WRAPPING_SUPPORT} {1}
set_instance_parameter_value DMA_to_SDRAM {CHANNEL_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {CHANNEL_WIDTH} {8}
set_instance_parameter_value DMA_to_SDRAM {DATA_FIFO_DEPTH} {2048}
set_instance_parameter_value DMA_to_SDRAM {DATA_WIDTH} {256}
set_instance_parameter_value DMA_to_SDRAM {DESCRIPTOR_FIFO_DEPTH} {32}
set_instance_parameter_value DMA_to_SDRAM {ENHANCED_FEATURES} {0}
set_instance_parameter_value DMA_to_SDRAM {ERROR_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {ERROR_WIDTH} {8}
set_instance_parameter_value DMA_to_SDRAM {EXPOSE_ST_PORT} {0}
set_instance_parameter_value DMA_to_SDRAM {FIX_ADDRESS_WIDTH} {32}
set_instance_parameter_value DMA_to_SDRAM {MAX_BURST_COUNT} {8}
set_instance_parameter_value DMA_to_SDRAM {MAX_BYTE} {65536}
set_instance_parameter_value DMA_to_SDRAM {MAX_STRIDE} {1}
set_instance_parameter_value DMA_to_SDRAM {MODE} {2}
set_instance_parameter_value DMA_to_SDRAM {PACKET_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {PREFETCHER_DATA_WIDTH} {32}
set_instance_parameter_value DMA_to_SDRAM {PREFETCHER_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {PREFETCHER_MAX_READ_BURST_COUNT} {2}
set_instance_parameter_value DMA_to_SDRAM {PREFETCHER_READ_BURST_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {PROGRAMMABLE_BURST_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {RESPONSE_PORT} {2}
set_instance_parameter_value DMA_to_SDRAM {STRIDE_ENABLE} {0}
set_instance_parameter_value DMA_to_SDRAM {TRANSFER_TYPE} {Full Word Accesses Only}
set_instance_parameter_value DMA_to_SDRAM {USE_FIX_ADDRESS_WIDTH} {0}

add_instance aes aes 1.0

add_instance aes_reset_controller altera_reset_controller 22.1
set_instance_parameter_value aes_reset_controller {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value aes_reset_controller {NUM_RESET_INPUTS} {1}
set_instance_parameter_value aes_reset_controller {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value aes_reset_controller {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value aes_reset_controller {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value aes_reset_controller {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value aes_reset_controller {SYNC_DEPTH} {2}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value aes_reset_controller {USE_RESET_REQUEST_INPUT} {0}

add_instance aes_reset_pio altera_avalon_pio 22.1
set_instance_parameter_value aes_reset_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value aes_reset_pio {bitModifyingOutReg} {0}
set_instance_parameter_value aes_reset_pio {captureEdge} {0}
set_instance_parameter_value aes_reset_pio {direction} {Output}
set_instance_parameter_value aes_reset_pio {edgeType} {RISING}
set_instance_parameter_value aes_reset_pio {generateIRQ} {0}
set_instance_parameter_value aes_reset_pio {irqType} {LEVEL}
set_instance_parameter_value aes_reset_pio {resetValue} {0.0}
set_instance_parameter_value aes_reset_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value aes_reset_pio {simDrivenValue} {0.0}
set_instance_parameter_value aes_reset_pio {width} {32}

add_instance hps_0 altera_hps 22.1
set_instance_parameter_value hps_0 {ABSTRACT_REAL_COMPARE_TEST} {0}
set_instance_parameter_value hps_0 {ABS_RAM_MEM_INIT_FILENAME} {meminit}
set_instance_parameter_value hps_0 {ACV_PHY_CLK_ADD_FR_PHASE} {0.0}
set_instance_parameter_value hps_0 {AC_PACKAGE_DESKEW} {0}
set_instance_parameter_value hps_0 {AC_ROM_USER_ADD_0} {0_0000_0000_0000}
set_instance_parameter_value hps_0 {AC_ROM_USER_ADD_1} {0_0000_0000_1000}
set_instance_parameter_value hps_0 {ADDR_ORDER} {0}
set_instance_parameter_value hps_0 {ADD_EFFICIENCY_MONITOR} {0}
set_instance_parameter_value hps_0 {ADD_EXTERNAL_SEQ_DEBUG_NIOS} {0}
set_instance_parameter_value hps_0 {ADVANCED_CK_PHASES} {0}
set_instance_parameter_value hps_0 {ADVERTIZE_SEQUENCER_SW_BUILD_FILES} {0}
set_instance_parameter_value hps_0 {AFI_DEBUG_INFO_WIDTH} {32}
set_instance_parameter_value hps_0 {ALTMEMPHY_COMPATIBLE_MODE} {0}
set_instance_parameter_value hps_0 {AP_MODE} {0}
set_instance_parameter_value hps_0 {AP_MODE_EN} {0}
set_instance_parameter_value hps_0 {AUTO_PD_CYCLES} {0}
set_instance_parameter_value hps_0 {AUTO_POWERDN_EN} {0}
set_instance_parameter_value hps_0 {AVL_DATA_WIDTH_PORT} {32 32 32 32 32 32}
set_instance_parameter_value hps_0 {AVL_MAX_SIZE} {4}
set_instance_parameter_value hps_0 {BONDING_OUT_ENABLED} {0}
set_instance_parameter_value hps_0 {BOOTFROMFPGA_Enable} {0}
set_instance_parameter_value hps_0 {BSEL} {1}
set_instance_parameter_value hps_0 {BSEL_EN} {0}
set_instance_parameter_value hps_0 {BYTE_ENABLE} {1}
set_instance_parameter_value hps_0 {C2P_WRITE_CLOCK_ADD_PHASE} {0.0}
set_instance_parameter_value hps_0 {CALIBRATION_MODE} {Skip}
set_instance_parameter_value hps_0 {CALIB_REG_WIDTH} {8}
set_instance_parameter_value hps_0 {CAN0_Mode} {N/A}
set_instance_parameter_value hps_0 {CAN0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {CAN1_Mode} {N/A}
set_instance_parameter_value hps_0 {CAN1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {CFG_DATA_REORDERING_TYPE} {INTER_BANK}
set_instance_parameter_value hps_0 {CFG_REORDER_DATA} {1}
set_instance_parameter_value hps_0 {CFG_TCCD_NS} {2.5}
set_instance_parameter_value hps_0 {COMMAND_PHASE} {0.0}
set_instance_parameter_value hps_0 {CONTROLLER_LATENCY} {5}
set_instance_parameter_value hps_0 {CORE_DEBUG_CONNECTION} {EXPORT}
set_instance_parameter_value hps_0 {CPORT_TYPE_PORT} {Bidirectional Bidirectional Bidirectional Bidirectional Bidirectional Bidirectional}
set_instance_parameter_value hps_0 {CSEL} {0}
set_instance_parameter_value hps_0 {CSEL_EN} {0}
set_instance_parameter_value hps_0 {CTI_Enable} {0}
set_instance_parameter_value hps_0 {CTL_AUTOPCH_EN} {0}
set_instance_parameter_value hps_0 {CTL_CMD_QUEUE_DEPTH} {8}
set_instance_parameter_value hps_0 {CTL_CSR_CONNECTION} {INTERNAL_JTAG}
set_instance_parameter_value hps_0 {CTL_CSR_ENABLED} {0}
set_instance_parameter_value hps_0 {CTL_CSR_READ_ONLY} {1}
set_instance_parameter_value hps_0 {CTL_DEEP_POWERDN_EN} {0}
set_instance_parameter_value hps_0 {CTL_DYNAMIC_BANK_ALLOCATION} {0}
set_instance_parameter_value hps_0 {CTL_DYNAMIC_BANK_NUM} {4}
set_instance_parameter_value hps_0 {CTL_ECC_AUTO_CORRECTION_ENABLED} {0}
set_instance_parameter_value hps_0 {CTL_ECC_ENABLED} {0}
set_instance_parameter_value hps_0 {CTL_ENABLE_BURST_INTERRUPT} {1}
set_instance_parameter_value hps_0 {CTL_ENABLE_BURST_TERMINATE} {1}
set_instance_parameter_value hps_0 {CTL_HRB_ENABLED} {0}
set_instance_parameter_value hps_0 {CTL_LOOK_AHEAD_DEPTH} {4}
set_instance_parameter_value hps_0 {CTL_SELF_REFRESH_EN} {0}
set_instance_parameter_value hps_0 {CTL_USR_REFRESH_EN} {0}
set_instance_parameter_value hps_0 {CTL_ZQCAL_EN} {0}
set_instance_parameter_value hps_0 {CUT_NEW_FAMILY_TIMING} {1}
set_instance_parameter_value hps_0 {DAT_DATA_WIDTH} {32}
set_instance_parameter_value hps_0 {DEBUGAPB_Enable} {0}
set_instance_parameter_value hps_0 {DEBUG_MODE} {0}
set_instance_parameter_value hps_0 {DEVICE_DEPTH} {1}
set_instance_parameter_value hps_0 {DEVICE_FAMILY_PARAM} {}
set_instance_parameter_value hps_0 {DISABLE_CHILD_MESSAGING} {0}
set_instance_parameter_value hps_0 {DISCRETE_FLY_BY} {1}
set_instance_parameter_value hps_0 {DLL_SHARING_MODE} {None}
set_instance_parameter_value hps_0 {DMA_Enable} {No No No No No No No No}
set_instance_parameter_value hps_0 {DQS_DQSN_MODE} {DIFFERENTIAL}
set_instance_parameter_value hps_0 {DQ_INPUT_REG_USE_CLKN} {0}
set_instance_parameter_value hps_0 {DUPLICATE_AC} {0}
set_instance_parameter_value hps_0 {ED_EXPORT_SEQ_DEBUG} {0}
set_instance_parameter_value hps_0 {EMAC0_Mode} {N/A}
set_instance_parameter_value hps_0 {EMAC0_PTP} {0}
set_instance_parameter_value hps_0 {EMAC0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {EMAC1_Mode} {N/A}
set_instance_parameter_value hps_0 {EMAC1_PTP} {0}
set_instance_parameter_value hps_0 {EMAC1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {ENABLE_ABS_RAM_MEM_INIT} {0}
set_instance_parameter_value hps_0 {ENABLE_BONDING} {0}
set_instance_parameter_value hps_0 {ENABLE_BURST_MERGE} {0}
set_instance_parameter_value hps_0 {ENABLE_CTRL_AVALON_INTERFACE} {1}
set_instance_parameter_value hps_0 {ENABLE_DELAY_CHAIN_WRITE} {0}
set_instance_parameter_value hps_0 {ENABLE_EMIT_BFM_MASTER} {0}
set_instance_parameter_value hps_0 {ENABLE_EXPORT_SEQ_DEBUG_BRIDGE} {0}
set_instance_parameter_value hps_0 {ENABLE_EXTRA_REPORTING} {0}
set_instance_parameter_value hps_0 {ENABLE_ISS_PROBES} {0}
set_instance_parameter_value hps_0 {ENABLE_NON_DESTRUCTIVE_CALIB} {0}
set_instance_parameter_value hps_0 {ENABLE_NON_DES_CAL} {0}
set_instance_parameter_value hps_0 {ENABLE_NON_DES_CAL_TEST} {0}
set_instance_parameter_value hps_0 {ENABLE_SEQUENCER_MARGINING_ON_BY_DEFAULT} {0}
set_instance_parameter_value hps_0 {ENABLE_USER_ECC} {0}
set_instance_parameter_value hps_0 {EXPORT_AFI_HALF_CLK} {0}
set_instance_parameter_value hps_0 {EXTRA_SETTINGS} {}
set_instance_parameter_value hps_0 {F2SCLK_COLDRST_Enable} {0}
set_instance_parameter_value hps_0 {F2SCLK_DBGRST_Enable} {0}
set_instance_parameter_value hps_0 {F2SCLK_PERIPHCLK_Enable} {0}
set_instance_parameter_value hps_0 {F2SCLK_SDRAMCLK_Enable} {0}
set_instance_parameter_value hps_0 {F2SCLK_WARMRST_Enable} {0}
set_instance_parameter_value hps_0 {F2SDRAM_Type} {Avalon-MM\ Write-Only}
set_instance_parameter_value hps_0 {F2SDRAM_Width} {256}
set_instance_parameter_value hps_0 {F2SINTERRUPT_Enable} {1}
set_instance_parameter_value hps_0 {F2S_Width} {0}
set_instance_parameter_value hps_0 {FIX_READ_LATENCY} {8}
set_instance_parameter_value hps_0 {FORCED_NON_LDC_ADDR_CMD_MEM_CK_INVERT} {0}
set_instance_parameter_value hps_0 {FORCED_NUM_WRITE_FR_CYCLE_SHIFTS} {0}
set_instance_parameter_value hps_0 {FORCE_DQS_TRACKING} {AUTO}
set_instance_parameter_value hps_0 {FORCE_MAX_LATENCY_COUNT_WIDTH} {0}
set_instance_parameter_value hps_0 {FORCE_SEQUENCER_TCL_DEBUG_MODE} {0}
set_instance_parameter_value hps_0 {FORCE_SHADOW_REGS} {AUTO}
set_instance_parameter_value hps_0 {FORCE_SYNTHESIS_LANGUAGE} {}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_EMAC0_GTX_CLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_EMAC0_MD_CLK} {100.0}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_EMAC1_GTX_CLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_EMAC1_MD_CLK} {100.0}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_I2C0_CLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_I2C1_CLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_I2C2_CLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_I2C3_CLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_QSPI_SCLK_OUT} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_SDIO_CCLK} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_SPIM0_SCLK_OUT} {100}
set_instance_parameter_value hps_0 {FPGA_PERIPHERAL_OUTPUT_CLOCK_FREQ_SPIM1_SCLK_OUT} {100}
set_instance_parameter_value hps_0 {GPIO_Enable} {No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No}
set_instance_parameter_value hps_0 {GP_Enable} {0}
set_instance_parameter_value hps_0 {HARD_EMIF} {1}
set_instance_parameter_value hps_0 {HCX_COMPAT_MODE} {0}
set_instance_parameter_value hps_0 {HHP_HPS} {1}
set_instance_parameter_value hps_0 {HHP_HPS_SIMULATION} {0}
set_instance_parameter_value hps_0 {HHP_HPS_VERIFICATION} {0}
set_instance_parameter_value hps_0 {HLGPI_Enable} {0}
set_instance_parameter_value hps_0 {HPS_PROTOCOL} {DDR3}
set_instance_parameter_value hps_0 {I2C0_Mode} {N/A}
set_instance_parameter_value hps_0 {I2C0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {I2C1_Mode} {N/A}
set_instance_parameter_value hps_0 {I2C1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {I2C2_Mode} {N/A}
set_instance_parameter_value hps_0 {I2C2_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {I2C3_Mode} {N/A}
set_instance_parameter_value hps_0 {I2C3_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {INCLUDE_BOARD_DELAY_MODEL} {0}
set_instance_parameter_value hps_0 {INCLUDE_MULTIRANK_BOARD_DELAY_MODEL} {0}
set_instance_parameter_value hps_0 {IS_ES_DEVICE} {0}
set_instance_parameter_value hps_0 {LOANIO_Enable} {No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No No}
set_instance_parameter_value hps_0 {LOCAL_ID_WIDTH} {8}
set_instance_parameter_value hps_0 {LRDIMM_EXTENDED_CONFIG} {0x000000000000000000}
set_instance_parameter_value hps_0 {LWH2F_Enable} {true}
set_instance_parameter_value hps_0 {MARGIN_VARIATION_TEST} {0}
set_instance_parameter_value hps_0 {MAX_PENDING_RD_CMD} {16}
set_instance_parameter_value hps_0 {MAX_PENDING_WR_CMD} {8}
set_instance_parameter_value hps_0 {MEM_ASR} {Manual}
set_instance_parameter_value hps_0 {MEM_ATCL} {Disabled}
set_instance_parameter_value hps_0 {MEM_AUTO_LEVELING_MODE} {1}
set_instance_parameter_value hps_0 {MEM_BANKADDR_WIDTH} {3}
set_instance_parameter_value hps_0 {MEM_BL} {OTF}
set_instance_parameter_value hps_0 {MEM_BT} {Sequential}
set_instance_parameter_value hps_0 {MEM_CK_PHASE} {0.0}
set_instance_parameter_value hps_0 {MEM_CK_WIDTH} {1}
set_instance_parameter_value hps_0 {MEM_CLK_EN_WIDTH} {1}
set_instance_parameter_value hps_0 {MEM_CLK_FREQ} {400.0}
set_instance_parameter_value hps_0 {MEM_CLK_FREQ_MAX} {800.0}
set_instance_parameter_value hps_0 {MEM_COL_ADDR_WIDTH} {10}
set_instance_parameter_value hps_0 {MEM_CS_WIDTH} {1}
set_instance_parameter_value hps_0 {MEM_DEVICE} {MISSING_MODEL}
set_instance_parameter_value hps_0 {MEM_DLL_EN} {1}
set_instance_parameter_value hps_0 {MEM_DQ_PER_DQS} {8}
set_instance_parameter_value hps_0 {MEM_DQ_WIDTH} {32}
set_instance_parameter_value hps_0 {MEM_DRV_STR} {RZQ/6}
set_instance_parameter_value hps_0 {MEM_FORMAT} {DISCRETE}
set_instance_parameter_value hps_0 {MEM_GUARANTEED_WRITE_INIT} {0}
set_instance_parameter_value hps_0 {MEM_IF_BOARD_BASE_DELAY} {10}
set_instance_parameter_value hps_0 {MEM_IF_DM_PINS_EN} {1}
set_instance_parameter_value hps_0 {MEM_IF_DQSN_EN} {1}
set_instance_parameter_value hps_0 {MEM_IF_SIM_VALID_WINDOW} {0}
set_instance_parameter_value hps_0 {MEM_INIT_EN} {0}
set_instance_parameter_value hps_0 {MEM_INIT_FILE} {}
set_instance_parameter_value hps_0 {MEM_MIRROR_ADDRESSING} {0}
set_instance_parameter_value hps_0 {MEM_NUMBER_OF_DIMMS} {1}
set_instance_parameter_value hps_0 {MEM_NUMBER_OF_RANKS_PER_DEVICE} {1}
set_instance_parameter_value hps_0 {MEM_NUMBER_OF_RANKS_PER_DIMM} {1}
set_instance_parameter_value hps_0 {MEM_PD} {DLL off}
set_instance_parameter_value hps_0 {MEM_RANK_MULTIPLICATION_FACTOR} {1}
set_instance_parameter_value hps_0 {MEM_ROW_ADDR_WIDTH} {15}
set_instance_parameter_value hps_0 {MEM_RTT_NOM} {RZQ/6}
set_instance_parameter_value hps_0 {MEM_RTT_WR} {Dynamic ODT off}
set_instance_parameter_value hps_0 {MEM_SRT} {Normal}
set_instance_parameter_value hps_0 {MEM_TCL} {7}
set_instance_parameter_value hps_0 {MEM_TFAW_NS} {37.5}
set_instance_parameter_value hps_0 {MEM_TINIT_US} {500}
set_instance_parameter_value hps_0 {MEM_TMRD_CK} {4}
set_instance_parameter_value hps_0 {MEM_TRAS_NS} {35.0}
set_instance_parameter_value hps_0 {MEM_TRCD_NS} {13.75}
set_instance_parameter_value hps_0 {MEM_TREFI_US} {7.8}
set_instance_parameter_value hps_0 {MEM_TRFC_NS} {300.0}
set_instance_parameter_value hps_0 {MEM_TRP_NS} {13.75}
set_instance_parameter_value hps_0 {MEM_TRRD_NS} {7.5}
set_instance_parameter_value hps_0 {MEM_TRTP_NS} {7.5}
set_instance_parameter_value hps_0 {MEM_TWR_NS} {15.0}
set_instance_parameter_value hps_0 {MEM_TWTR} {4}
set_instance_parameter_value hps_0 {MEM_USER_LEVELING_MODE} {Leveling}
set_instance_parameter_value hps_0 {MEM_VENDOR} {Other}
set_instance_parameter_value hps_0 {MEM_VERBOSE} {1}
set_instance_parameter_value hps_0 {MEM_VOLTAGE} {1.5V DDR3}
set_instance_parameter_value hps_0 {MEM_WTCL} {7}
set_instance_parameter_value hps_0 {MPU_EVENTS_Enable} {0}
set_instance_parameter_value hps_0 {MRS_MIRROR_PING_PONG_ATSO} {0}
set_instance_parameter_value hps_0 {MULTICAST_EN} {0}
set_instance_parameter_value hps_0 {NAND_Mode} {N/A}
set_instance_parameter_value hps_0 {NAND_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {NEXTGEN} {1}
set_instance_parameter_value hps_0 {NIOS_ROM_DATA_WIDTH} {32}
set_instance_parameter_value hps_0 {NUM_DLL_SHARING_INTERFACES} {1}
set_instance_parameter_value hps_0 {NUM_EXTRA_REPORT_PATH} {10}
set_instance_parameter_value hps_0 {NUM_OCT_SHARING_INTERFACES} {1}
set_instance_parameter_value hps_0 {NUM_OF_PORTS} {1}
set_instance_parameter_value hps_0 {NUM_PLL_SHARING_INTERFACES} {1}
set_instance_parameter_value hps_0 {OCT_SHARING_MODE} {None}
set_instance_parameter_value hps_0 {P2C_READ_CLOCK_ADD_PHASE} {0.0}
set_instance_parameter_value hps_0 {PACKAGE_DESKEW} {0}
set_instance_parameter_value hps_0 {PARSE_FRIENDLY_DEVICE_FAMILY_PARAM} {}
set_instance_parameter_value hps_0 {PARSE_FRIENDLY_DEVICE_FAMILY_PARAM_VALID} {0}
set_instance_parameter_value hps_0 {PHY_CSR_CONNECTION} {INTERNAL_JTAG}
set_instance_parameter_value hps_0 {PHY_CSR_ENABLED} {0}
set_instance_parameter_value hps_0 {PHY_ONLY} {0}
set_instance_parameter_value hps_0 {PINGPONGPHY_EN} {0}
set_instance_parameter_value hps_0 {PLL_ADDR_CMD_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_ADDR_CMD_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_ADDR_CMD_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_ADDR_CMD_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_ADDR_CMD_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_ADDR_CMD_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_AFI_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_AFI_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_AFI_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_AFI_HALF_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_HALF_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_AFI_HALF_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_AFI_HALF_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_HALF_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_HALF_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_AFI_PHY_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_PHY_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_AFI_PHY_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_AFI_PHY_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_PHY_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_AFI_PHY_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_C2P_WRITE_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_C2P_WRITE_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_C2P_WRITE_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_C2P_WRITE_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_C2P_WRITE_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_C2P_WRITE_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_CLK_PARAM_VALID} {0}
set_instance_parameter_value hps_0 {PLL_CONFIG_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_CONFIG_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_CONFIG_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_CONFIG_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_CONFIG_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_CONFIG_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_DR_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_DR_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_DR_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_DR_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_DR_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_DR_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_HR_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_HR_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_HR_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_HR_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_HR_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_HR_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_LOCATION} {Top_Bottom}
set_instance_parameter_value hps_0 {PLL_MEM_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_MEM_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_MEM_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_MEM_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_MEM_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_MEM_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_NIOS_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_NIOS_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_NIOS_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_NIOS_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_NIOS_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_NIOS_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_P2C_READ_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_P2C_READ_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_P2C_READ_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_P2C_READ_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_P2C_READ_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_P2C_READ_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_SHARING_MODE} {None}
set_instance_parameter_value hps_0 {PLL_WRITE_CLK_DIV_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_WRITE_CLK_FREQ_PARAM} {0.0}
set_instance_parameter_value hps_0 {PLL_WRITE_CLK_FREQ_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {PLL_WRITE_CLK_MULT_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_WRITE_CLK_PHASE_PS_PARAM} {0}
set_instance_parameter_value hps_0 {PLL_WRITE_CLK_PHASE_PS_SIM_STR_PARAM} {}
set_instance_parameter_value hps_0 {POWER_OF_TWO_BUS} {0}
set_instance_parameter_value hps_0 {PRIORITY_PORT} {1 1 1 1 1 1}
set_instance_parameter_value hps_0 {QSPI_Mode} {N/A}
set_instance_parameter_value hps_0 {QSPI_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {RATE} {Full}
set_instance_parameter_value hps_0 {RDIMM_CONFIG} {0000000000000000}
set_instance_parameter_value hps_0 {READ_DQ_DQS_CLOCK_SOURCE} {INVERTED_DQS_BUS}
set_instance_parameter_value hps_0 {READ_FIFO_SIZE} {8}
set_instance_parameter_value hps_0 {REFRESH_BURST_VALIDATION} {0}
set_instance_parameter_value hps_0 {REFRESH_INTERVAL} {15000}
set_instance_parameter_value hps_0 {REF_CLK_FREQ} {25.0}
set_instance_parameter_value hps_0 {REF_CLK_FREQ_MAX_PARAM} {0.0}
set_instance_parameter_value hps_0 {REF_CLK_FREQ_MIN_PARAM} {0.0}
set_instance_parameter_value hps_0 {REF_CLK_FREQ_PARAM_VALID} {0}
set_instance_parameter_value hps_0 {S2FCLK_COLDRST_Enable} {0}
set_instance_parameter_value hps_0 {S2FCLK_PENDINGRST_Enable} {0}
set_instance_parameter_value hps_0 {S2FCLK_USER0CLK_Enable} {0}
set_instance_parameter_value hps_0 {S2FCLK_USER1CLK_Enable} {0}
set_instance_parameter_value hps_0 {S2FCLK_USER1CLK_FREQ} {100.0}
set_instance_parameter_value hps_0 {S2FCLK_USER2CLK} {4}
set_instance_parameter_value hps_0 {S2FCLK_USER2CLK_Enable} {0}
set_instance_parameter_value hps_0 {S2FCLK_USER2CLK_FREQ} {100.0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_CAN_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_CLOCKPERIPHERAL_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_CTI_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_DMA_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_EMAC_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_FPGAMANAGER_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_GPIO_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_I2CEMAC_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_I2CPERIPHERAL_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_L4TIMER_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_NAND_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_OSCTIMER_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_QSPI_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_SDMMC_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_SPIMASTER_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_SPISLAVE_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_UART_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_USB_Enable} {0}
set_instance_parameter_value hps_0 {S2FINTERRUPT_WATCHDOG_Enable} {0}
set_instance_parameter_value hps_0 {S2F_Width} {1}
set_instance_parameter_value hps_0 {SDIO_Mode} {N/A}
set_instance_parameter_value hps_0 {SDIO_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {SEQUENCER_TYPE} {NIOS}
set_instance_parameter_value hps_0 {SEQ_MODE} {0}
set_instance_parameter_value hps_0 {SKIP_MEM_INIT} {1}
set_instance_parameter_value hps_0 {SOPC_COMPAT_RESET} {0}
set_instance_parameter_value hps_0 {SPEED_GRADE} {7}
set_instance_parameter_value hps_0 {SPIM0_Mode} {N/A}
set_instance_parameter_value hps_0 {SPIM0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {SPIM1_Mode} {N/A}
set_instance_parameter_value hps_0 {SPIM1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {SPIS0_Mode} {N/A}
set_instance_parameter_value hps_0 {SPIS0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {SPIS1_Mode} {N/A}
set_instance_parameter_value hps_0 {SPIS1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {STARVE_LIMIT} {10}
set_instance_parameter_value hps_0 {STM_Enable} {0}
set_instance_parameter_value hps_0 {TEST_Enable} {0}
set_instance_parameter_value hps_0 {TIMING_BOARD_AC_EYE_REDUCTION_H} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_AC_EYE_REDUCTION_SU} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_AC_SKEW} {0.02}
set_instance_parameter_value hps_0 {TIMING_BOARD_AC_SLEW_RATE} {1.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_AC_TO_CK_SKEW} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_CK_CKN_SLEW_RATE} {2.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_DELTA_DQS_ARRIVAL_TIME} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_DELTA_READ_DQS_ARRIVAL_TIME} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_DERATE_METHOD} {AUTO}
set_instance_parameter_value hps_0 {TIMING_BOARD_DQS_DQSN_SLEW_RATE} {2.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_DQ_EYE_REDUCTION} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_DQ_SLEW_RATE} {1.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_DQ_TO_DQS_SKEW} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_ISI_METHOD} {AUTO}
set_instance_parameter_value hps_0 {TIMING_BOARD_MAX_CK_DELAY} {0.6}
set_instance_parameter_value hps_0 {TIMING_BOARD_MAX_DQS_DELAY} {0.6}
set_instance_parameter_value hps_0 {TIMING_BOARD_READ_DQ_EYE_REDUCTION} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_SKEW_BETWEEN_DIMMS} {0.05}
set_instance_parameter_value hps_0 {TIMING_BOARD_SKEW_BETWEEN_DQS} {0.02}
set_instance_parameter_value hps_0 {TIMING_BOARD_SKEW_CKDQS_DIMM_MAX} {0.01}
set_instance_parameter_value hps_0 {TIMING_BOARD_SKEW_CKDQS_DIMM_MIN} {-0.01}
set_instance_parameter_value hps_0 {TIMING_BOARD_SKEW_WITHIN_DQS} {0.02}
set_instance_parameter_value hps_0 {TIMING_BOARD_TDH} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_TDS} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_TIH} {0.0}
set_instance_parameter_value hps_0 {TIMING_BOARD_TIS} {0.0}
set_instance_parameter_value hps_0 {TIMING_TDH} {125}
set_instance_parameter_value hps_0 {TIMING_TDQSCK} {400}
set_instance_parameter_value hps_0 {TIMING_TDQSCKDL} {1200}
set_instance_parameter_value hps_0 {TIMING_TDQSCKDM} {900}
set_instance_parameter_value hps_0 {TIMING_TDQSCKDS} {450}
set_instance_parameter_value hps_0 {TIMING_TDQSH} {0.35}
set_instance_parameter_value hps_0 {TIMING_TDQSQ} {120}
set_instance_parameter_value hps_0 {TIMING_TDQSS} {0.25}
set_instance_parameter_value hps_0 {TIMING_TDS} {50}
set_instance_parameter_value hps_0 {TIMING_TDSH} {0.2}
set_instance_parameter_value hps_0 {TIMING_TDSS} {0.2}
set_instance_parameter_value hps_0 {TIMING_TIH} {250}
set_instance_parameter_value hps_0 {TIMING_TIS} {175}
set_instance_parameter_value hps_0 {TIMING_TQH} {0.38}
set_instance_parameter_value hps_0 {TIMING_TQHS} {300}
set_instance_parameter_value hps_0 {TIMING_TQSH} {0.38}
set_instance_parameter_value hps_0 {TPIUFPGA_Enable} {0}
set_instance_parameter_value hps_0 {TPIUFPGA_alt} {0}
set_instance_parameter_value hps_0 {TRACE_Mode} {N/A}
set_instance_parameter_value hps_0 {TRACE_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {TRACKING_ERROR_TEST} {0}
set_instance_parameter_value hps_0 {TRACKING_WATCH_TEST} {0}
set_instance_parameter_value hps_0 {TREFI} {35100}
set_instance_parameter_value hps_0 {TRFC} {350}
set_instance_parameter_value hps_0 {UART0_Mode} {N/A}
set_instance_parameter_value hps_0 {UART0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {UART1_Mode} {N/A}
set_instance_parameter_value hps_0 {UART1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {USB0_Mode} {N/A}
set_instance_parameter_value hps_0 {USB0_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {USB1_Mode} {N/A}
set_instance_parameter_value hps_0 {USB1_PinMuxing} {Unused}
set_instance_parameter_value hps_0 {USER_DEBUG_LEVEL} {1}
set_instance_parameter_value hps_0 {USE_AXI_ADAPTOR} {0}
set_instance_parameter_value hps_0 {USE_FAKE_PHY} {0}
set_instance_parameter_value hps_0 {USE_MEM_CLK_FREQ} {0}
set_instance_parameter_value hps_0 {USE_MM_ADAPTOR} {1}
set_instance_parameter_value hps_0 {USE_SEQUENCER_BFM} {0}
set_instance_parameter_value hps_0 {WEIGHT_PORT} {0 0 0 0 0 0}
set_instance_parameter_value hps_0 {WRBUFFER_ADDR_WIDTH} {6}
set_instance_parameter_value hps_0 {can0_clk_div} {1}
set_instance_parameter_value hps_0 {can1_clk_div} {1}
set_instance_parameter_value hps_0 {configure_advanced_parameters} {0}
set_instance_parameter_value hps_0 {customize_device_pll_info} {0}
set_instance_parameter_value hps_0 {dbctrl_stayosc1} {1}
set_instance_parameter_value hps_0 {dbg_at_clk_div} {0}
set_instance_parameter_value hps_0 {dbg_clk_div} {1}
set_instance_parameter_value hps_0 {dbg_trace_clk_div} {0}
set_instance_parameter_value hps_0 {desired_can0_clk_mhz} {100.0}
set_instance_parameter_value hps_0 {desired_can1_clk_mhz} {100.0}
set_instance_parameter_value hps_0 {desired_cfg_clk_mhz} {100.0}
set_instance_parameter_value hps_0 {desired_emac0_clk_mhz} {250.0}
set_instance_parameter_value hps_0 {desired_emac1_clk_mhz} {250.0}
set_instance_parameter_value hps_0 {desired_gpio_db_clk_hz} {32000}
set_instance_parameter_value hps_0 {desired_l4_mp_clk_mhz} {100.0}
set_instance_parameter_value hps_0 {desired_l4_sp_clk_mhz} {100.0}
set_instance_parameter_value hps_0 {desired_mpu_clk_mhz} {800.0}
set_instance_parameter_value hps_0 {desired_nand_clk_mhz} {12.5}
set_instance_parameter_value hps_0 {desired_qspi_clk_mhz} {370.0}
set_instance_parameter_value hps_0 {desired_sdmmc_clk_mhz} {200.0}
set_instance_parameter_value hps_0 {desired_spi_m_clk_mhz} {200.0}
set_instance_parameter_value hps_0 {desired_usb_mp_clk_mhz} {200.0}
set_instance_parameter_value hps_0 {device_pll_info_manual} {{320000000 1600000000} {320000000 1000000000} {800000000 400000000 400000000}}
set_instance_parameter_value hps_0 {eosc1_clk_mhz} {25.0}
set_instance_parameter_value hps_0 {eosc2_clk_mhz} {25.0}
set_instance_parameter_value hps_0 {gpio_db_clk_div} {6249}
set_instance_parameter_value hps_0 {l3_mp_clk_div} {1}
set_instance_parameter_value hps_0 {l3_sp_clk_div} {1}
set_instance_parameter_value hps_0 {l4_mp_clk_div} {1}
set_instance_parameter_value hps_0 {l4_mp_clk_source} {1}
set_instance_parameter_value hps_0 {l4_sp_clk_div} {1}
set_instance_parameter_value hps_0 {l4_sp_clk_source} {1}
set_instance_parameter_value hps_0 {main_pll_c3} {3}
set_instance_parameter_value hps_0 {main_pll_c4} {3}
set_instance_parameter_value hps_0 {main_pll_c5} {15}
set_instance_parameter_value hps_0 {main_pll_m} {63}
set_instance_parameter_value hps_0 {main_pll_n} {0}
set_instance_parameter_value hps_0 {nand_clk_source} {2}
set_instance_parameter_value hps_0 {periph_pll_c0} {3}
set_instance_parameter_value hps_0 {periph_pll_c1} {3}
set_instance_parameter_value hps_0 {periph_pll_c2} {1}
set_instance_parameter_value hps_0 {periph_pll_c3} {19}
set_instance_parameter_value hps_0 {periph_pll_c4} {4}
set_instance_parameter_value hps_0 {periph_pll_c5} {9}
set_instance_parameter_value hps_0 {periph_pll_m} {79}
set_instance_parameter_value hps_0 {periph_pll_n} {1}
set_instance_parameter_value hps_0 {periph_pll_source} {0}
set_instance_parameter_value hps_0 {qspi_clk_source} {1}
set_instance_parameter_value hps_0 {sdmmc_clk_source} {2}
set_instance_parameter_value hps_0 {show_advanced_parameters} {0}
set_instance_parameter_value hps_0 {show_debug_info_as_warning_msg} {0}
set_instance_parameter_value hps_0 {show_warning_as_error_msg} {0}
set_instance_parameter_value hps_0 {spi_m_clk_div} {0}
set_instance_parameter_value hps_0 {usb_mp_clk_div} {0}
set_instance_parameter_value hps_0 {use_default_mpu_clk} {1}

add_instance input_clk clock_source 22.1
set_instance_parameter_value input_clk {clockFrequency} {50000000.0}
set_instance_parameter_value input_clk {clockFrequencyKnown} {1}
set_instance_parameter_value input_clk {resetSynchronousEdges} {NONE}

add_instance ip_sync ip_sync 1.0
set_instance_parameter_value ip_sync {ADDR_TRIGGER} {8}
set_instance_parameter_value ip_sync {DATA_TRIGGER} {2}

add_instance ip_sync_to_pulsegenerator_cdc altera_avalon_dc_fifo 22.1
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {BITS_PER_SYMBOL} {8}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {CHANNEL_WIDTH} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {ENABLE_EXPLICIT_MAXCHANNEL} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {ERROR_WIDTH} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {EXPLICIT_MAXCHANNEL} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {FIFO_DEPTH} {16}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {RD_SYNC_DEPTH} {8}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {SYMBOLS_PER_BEAT} {1}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {USE_IN_FILL_LEVEL} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {USE_OUT_FILL_LEVEL} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {USE_PACKETS} {0}
set_instance_parameter_value ip_sync_to_pulsegenerator_cdc {WR_SYNC_DEPTH} {8}

add_instance ipsync_bridge altera_avalon_mm_clock_crossing_bridge 22.1
set_instance_parameter_value ipsync_bridge {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value ipsync_bridge {ADDRESS_WIDTH} {10}
set_instance_parameter_value ipsync_bridge {COMMAND_FIFO_DEPTH} {8}
set_instance_parameter_value ipsync_bridge {DATA_WIDTH} {32}
set_instance_parameter_value ipsync_bridge {MASTER_SYNC_DEPTH} {8}
set_instance_parameter_value ipsync_bridge {MAX_BURST_SIZE} {1}
set_instance_parameter_value ipsync_bridge {RESPONSE_FIFO_DEPTH} {8}
set_instance_parameter_value ipsync_bridge {SLAVE_SYNC_DEPTH} {8}
set_instance_parameter_value ipsync_bridge {SYMBOL_WIDTH} {8}
set_instance_parameter_value ipsync_bridge {USE_AUTO_ADDRESS_WIDTH} {1}

add_instance ipsync_to_aes_delay altera_avalon_mm_clock_crossing_bridge 22.1
set_instance_parameter_value ipsync_to_aes_delay {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value ipsync_to_aes_delay {ADDRESS_WIDTH} {10}
set_instance_parameter_value ipsync_to_aes_delay {COMMAND_FIFO_DEPTH} {8}
set_instance_parameter_value ipsync_to_aes_delay {DATA_WIDTH} {32}
set_instance_parameter_value ipsync_to_aes_delay {MASTER_SYNC_DEPTH} {16}
set_instance_parameter_value ipsync_to_aes_delay {MAX_BURST_SIZE} {1}
set_instance_parameter_value ipsync_to_aes_delay {RESPONSE_FIFO_DEPTH} {8}
set_instance_parameter_value ipsync_to_aes_delay {SLAVE_SYNC_DEPTH} {16}
set_instance_parameter_value ipsync_to_aes_delay {SYMBOL_WIDTH} {8}
set_instance_parameter_value ipsync_to_aes_delay {USE_AUTO_ADDRESS_WIDTH} {0}

add_instance phi_clk altera_pll 22.1
set_instance_parameter_value phi_clk {debug_print_output} {0}
set_instance_parameter_value phi_clk {debug_use_rbc_taf_method} {0}
set_instance_parameter_value phi_clk {gui_active_clk} {0}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency0} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency1} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency10} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency11} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency12} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency13} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency14} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency15} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency16} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency17} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency2} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency3} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency4} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency5} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency6} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency7} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency8} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_output_clock_frequency9} {0 MHz}
set_instance_parameter_value phi_clk {gui_actual_phase_shift0} {0 ps}
set_instance_parameter_value phi_clk {gui_actual_phase_shift1} {0 ps}
set_instance_parameter_value phi_clk {gui_actual_phase_shift10} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift11} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift12} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift13} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift14} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift15} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift16} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift17} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift2} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift3} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift4} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift5} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift6} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift7} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift8} {0}
set_instance_parameter_value phi_clk {gui_actual_phase_shift9} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter0} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter1} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter10} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter11} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter12} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter13} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter14} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter15} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter16} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter17} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter2} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter3} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter4} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter5} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter6} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter7} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter8} {0}
set_instance_parameter_value phi_clk {gui_cascade_counter9} {0}
set_instance_parameter_value phi_clk {gui_cascade_outclk_index} {0}
set_instance_parameter_value phi_clk {gui_channel_spacing} {0.0}
set_instance_parameter_value phi_clk {gui_clk_bad} {0}
set_instance_parameter_value phi_clk {gui_device_speed_grade} {2}
set_instance_parameter_value phi_clk {gui_divide_factor_c0} {32}
set_instance_parameter_value phi_clk {gui_divide_factor_c1} {16}
set_instance_parameter_value phi_clk {gui_divide_factor_c10} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c11} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c12} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c13} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c14} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c15} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c16} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c17} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c2} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c3} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c4} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c5} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c6} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c7} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c8} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_c9} {1}
set_instance_parameter_value phi_clk {gui_divide_factor_n} {1}
set_instance_parameter_value phi_clk {gui_dps_cntr} {C0}
set_instance_parameter_value phi_clk {gui_dps_dir} {Positive}
set_instance_parameter_value phi_clk {gui_dps_num} {1}
set_instance_parameter_value phi_clk {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value phi_clk {gui_duty_cycle0} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle1} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle10} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle11} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle12} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle13} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle14} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle15} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle16} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle17} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle2} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle3} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle4} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle5} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle6} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle7} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle8} {50}
set_instance_parameter_value phi_clk {gui_duty_cycle9} {50}
set_instance_parameter_value phi_clk {gui_en_adv_params} {1}
set_instance_parameter_value phi_clk {gui_en_dps_ports} {0}
set_instance_parameter_value phi_clk {gui_en_phout_ports} {0}
set_instance_parameter_value phi_clk {gui_en_reconf} {1}
set_instance_parameter_value phi_clk {gui_enable_cascade_in} {0}
set_instance_parameter_value phi_clk {gui_enable_cascade_out} {1}
set_instance_parameter_value phi_clk {gui_enable_mif_dps} {0}
set_instance_parameter_value phi_clk {gui_feedback_clock} {Global Clock}
set_instance_parameter_value phi_clk {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value phi_clk {gui_fractional_cout} {8}
set_instance_parameter_value phi_clk {gui_mif_generate} {0}
set_instance_parameter_value phi_clk {gui_multiply_factor} {32}
set_instance_parameter_value phi_clk {gui_number_of_clocks} {1}
set_instance_parameter_value phi_clk {gui_operation_mode} {direct}
set_instance_parameter_value phi_clk {gui_output_clock_frequency0} {300.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency1} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency10} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency11} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency12} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency13} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency14} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency15} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency16} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency17} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency2} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency3} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency4} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency5} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency6} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency7} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency8} {100.0}
set_instance_parameter_value phi_clk {gui_output_clock_frequency9} {100.0}
set_instance_parameter_value phi_clk {gui_phase_shift0} {0}
set_instance_parameter_value phi_clk {gui_phase_shift1} {0}
set_instance_parameter_value phi_clk {gui_phase_shift10} {0}
set_instance_parameter_value phi_clk {gui_phase_shift11} {0}
set_instance_parameter_value phi_clk {gui_phase_shift12} {0}
set_instance_parameter_value phi_clk {gui_phase_shift13} {0}
set_instance_parameter_value phi_clk {gui_phase_shift14} {0}
set_instance_parameter_value phi_clk {gui_phase_shift15} {0}
set_instance_parameter_value phi_clk {gui_phase_shift16} {0}
set_instance_parameter_value phi_clk {gui_phase_shift17} {0}
set_instance_parameter_value phi_clk {gui_phase_shift2} {0}
set_instance_parameter_value phi_clk {gui_phase_shift3} {0}
set_instance_parameter_value phi_clk {gui_phase_shift4} {0}
set_instance_parameter_value phi_clk {gui_phase_shift5} {0}
set_instance_parameter_value phi_clk {gui_phase_shift6} {0}
set_instance_parameter_value phi_clk {gui_phase_shift7} {0}
set_instance_parameter_value phi_clk {gui_phase_shift8} {0}
set_instance_parameter_value phi_clk {gui_phase_shift9} {0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg0} {164.9}
set_instance_parameter_value phi_clk {gui_phase_shift_deg1} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg10} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg11} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg12} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg13} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg14} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg15} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg16} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg17} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg2} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg3} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg4} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg5} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg6} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg7} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg8} {0.0}
set_instance_parameter_value phi_clk {gui_phase_shift_deg9} {0.0}
set_instance_parameter_value phi_clk {gui_phout_division} {1}
set_instance_parameter_value phi_clk {gui_pll_auto_reset} {Off}
set_instance_parameter_value phi_clk {gui_pll_bandwidth_preset} {Low}
set_instance_parameter_value phi_clk {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}
set_instance_parameter_value phi_clk {gui_pll_mode} {Integer-N PLL}
set_instance_parameter_value phi_clk {gui_ps_units0} {ps}
set_instance_parameter_value phi_clk {gui_ps_units1} {ps}
set_instance_parameter_value phi_clk {gui_ps_units10} {ps}
set_instance_parameter_value phi_clk {gui_ps_units11} {ps}
set_instance_parameter_value phi_clk {gui_ps_units12} {ps}
set_instance_parameter_value phi_clk {gui_ps_units13} {ps}
set_instance_parameter_value phi_clk {gui_ps_units14} {ps}
set_instance_parameter_value phi_clk {gui_ps_units15} {ps}
set_instance_parameter_value phi_clk {gui_ps_units16} {ps}
set_instance_parameter_value phi_clk {gui_ps_units17} {ps}
set_instance_parameter_value phi_clk {gui_ps_units2} {ps}
set_instance_parameter_value phi_clk {gui_ps_units3} {ps}
set_instance_parameter_value phi_clk {gui_ps_units4} {ps}
set_instance_parameter_value phi_clk {gui_ps_units5} {ps}
set_instance_parameter_value phi_clk {gui_ps_units6} {ps}
set_instance_parameter_value phi_clk {gui_ps_units7} {ps}
set_instance_parameter_value phi_clk {gui_ps_units8} {ps}
set_instance_parameter_value phi_clk {gui_ps_units9} {ps}
set_instance_parameter_value phi_clk {gui_refclk1_frequency} {100.0}
set_instance_parameter_value phi_clk {gui_refclk_switch} {0}
set_instance_parameter_value phi_clk {gui_reference_clock_frequency} {50.0}
set_instance_parameter_value phi_clk {gui_switchover_delay} {0}
set_instance_parameter_value phi_clk {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value phi_clk {gui_use_locked} {1}

add_instance phi_locked altera_avalon_pio 22.1
set_instance_parameter_value phi_locked {bitClearingEdgeCapReg} {0}
set_instance_parameter_value phi_locked {bitModifyingOutReg} {0}
set_instance_parameter_value phi_locked {captureEdge} {0}
set_instance_parameter_value phi_locked {direction} {Input}
set_instance_parameter_value phi_locked {edgeType} {RISING}
set_instance_parameter_value phi_locked {generateIRQ} {0}
set_instance_parameter_value phi_locked {irqType} {LEVEL}
set_instance_parameter_value phi_locked {resetValue} {0.0}
set_instance_parameter_value phi_locked {simDoTestBenchWiring} {0}
set_instance_parameter_value phi_locked {simDrivenValue} {0.0}
set_instance_parameter_value phi_locked {width} {32}

add_instance phi_pll_reconfig altera_pll_reconfig 22.1
set_instance_parameter_value phi_pll_reconfig {ENABLE_BYTEENABLE} {0}
set_instance_parameter_value phi_pll_reconfig {ENABLE_MIF} {0}
set_instance_parameter_value phi_pll_reconfig {MIF_FILE_NAME} {}

add_instance phi_pll_reconfig_cdc altera_avalon_mm_clock_crossing_bridge 22.1
set_instance_parameter_value phi_pll_reconfig_cdc {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value phi_pll_reconfig_cdc {ADDRESS_WIDTH} {6}
set_instance_parameter_value phi_pll_reconfig_cdc {COMMAND_FIFO_DEPTH} {8}
set_instance_parameter_value phi_pll_reconfig_cdc {DATA_WIDTH} {32}
set_instance_parameter_value phi_pll_reconfig_cdc {MASTER_SYNC_DEPTH} {8}
set_instance_parameter_value phi_pll_reconfig_cdc {MAX_BURST_SIZE} {1}
set_instance_parameter_value phi_pll_reconfig_cdc {RESPONSE_FIFO_DEPTH} {8}
set_instance_parameter_value phi_pll_reconfig_cdc {SLAVE_SYNC_DEPTH} {8}
set_instance_parameter_value phi_pll_reconfig_cdc {SYMBOL_WIDTH} {8}
set_instance_parameter_value phi_pll_reconfig_cdc {USE_AUTO_ADDRESS_WIDTH} {1}

add_instance phi_pll_reset_bridge altera_reset_controller 22.1
set_instance_parameter_value phi_pll_reset_bridge {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value phi_pll_reset_bridge {NUM_RESET_INPUTS} {1}
set_instance_parameter_value phi_pll_reset_bridge {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value phi_pll_reset_bridge {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value phi_pll_reset_bridge {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value phi_pll_reset_bridge {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value phi_pll_reset_bridge {SYNC_DEPTH} {2}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value phi_pll_reset_bridge {USE_RESET_REQUEST_INPUT} {0}

add_instance phi_pll_reset_pio altera_avalon_pio 22.1
set_instance_parameter_value phi_pll_reset_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value phi_pll_reset_pio {bitModifyingOutReg} {0}
set_instance_parameter_value phi_pll_reset_pio {captureEdge} {0}
set_instance_parameter_value phi_pll_reset_pio {direction} {Output}
set_instance_parameter_value phi_pll_reset_pio {edgeType} {RISING}
set_instance_parameter_value phi_pll_reset_pio {generateIRQ} {0}
set_instance_parameter_value phi_pll_reset_pio {irqType} {LEVEL}
set_instance_parameter_value phi_pll_reset_pio {resetValue} {0.0}
set_instance_parameter_value phi_pll_reset_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value phi_pll_reset_pio {simDrivenValue} {0.0}
set_instance_parameter_value phi_pll_reset_pio {width} {32}

add_instance pulsegenerator pulse_generator 1.0
set_instance_parameter_value pulsegenerator {C_SELECT_BIT} {1}
set_instance_parameter_value pulsegenerator {PIPELINE_OUTPUT} {4}

add_instance pulsegenerator_cdc altera_avalon_mm_clock_crossing_bridge 22.1
set_instance_parameter_value pulsegenerator_cdc {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value pulsegenerator_cdc {ADDRESS_WIDTH} {12}
set_instance_parameter_value pulsegenerator_cdc {COMMAND_FIFO_DEPTH} {8}
set_instance_parameter_value pulsegenerator_cdc {DATA_WIDTH} {32}
set_instance_parameter_value pulsegenerator_cdc {MASTER_SYNC_DEPTH} {8}
set_instance_parameter_value pulsegenerator_cdc {MAX_BURST_SIZE} {1}
set_instance_parameter_value pulsegenerator_cdc {RESPONSE_FIFO_DEPTH} {8}
set_instance_parameter_value pulsegenerator_cdc {SLAVE_SYNC_DEPTH} {8}
set_instance_parameter_value pulsegenerator_cdc {SYMBOL_WIDTH} {8}
set_instance_parameter_value pulsegenerator_cdc {USE_AUTO_ADDRESS_WIDTH} {1}

add_instance reset_bridge_capt altera_reset_controller 22.1
set_instance_parameter_value reset_bridge_capt {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value reset_bridge_capt {NUM_RESET_INPUTS} {1}
set_instance_parameter_value reset_bridge_capt {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value reset_bridge_capt {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value reset_bridge_capt {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value reset_bridge_capt {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value reset_bridge_capt {SYNC_DEPTH} {2}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value reset_bridge_capt {USE_RESET_REQUEST_INPUT} {0}

add_instance reset_bridge_launch altera_reset_controller 22.1
set_instance_parameter_value reset_bridge_launch {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value reset_bridge_launch {NUM_RESET_INPUTS} {1}
set_instance_parameter_value reset_bridge_launch {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value reset_bridge_launch {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value reset_bridge_launch {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value reset_bridge_launch {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value reset_bridge_launch {SYNC_DEPTH} {2}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value reset_bridge_launch {USE_RESET_REQUEST_INPUT} {0}

add_instance reset_bridge_shell altera_reset_controller 22.1
set_instance_parameter_value reset_bridge_shell {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value reset_bridge_shell {NUM_RESET_INPUTS} {1}
set_instance_parameter_value reset_bridge_shell {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value reset_bridge_shell {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value reset_bridge_shell {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value reset_bridge_shell {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value reset_bridge_shell {SYNC_DEPTH} {2}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value reset_bridge_shell {USE_RESET_REQUEST_INPUT} {0}

add_instance reset_bridge_tdc altera_reset_controller 22.1
set_instance_parameter_value reset_bridge_tdc {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value reset_bridge_tdc {NUM_RESET_INPUTS} {1}
set_instance_parameter_value reset_bridge_tdc {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value reset_bridge_tdc {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value reset_bridge_tdc {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value reset_bridge_tdc {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value reset_bridge_tdc {SYNC_DEPTH} {2}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value reset_bridge_tdc {USE_RESET_REQUEST_INPUT} {0}

add_instance shell_pll altera_pll 22.1
set_instance_parameter_value shell_pll {debug_print_output} {0}
set_instance_parameter_value shell_pll {debug_use_rbc_taf_method} {0}
set_instance_parameter_value shell_pll {gui_active_clk} {0}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency0} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency1} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency10} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency11} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency12} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency13} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency14} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency15} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency16} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency17} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency2} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency3} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency4} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency5} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency6} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency7} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency8} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_output_clock_frequency9} {0 MHz}
set_instance_parameter_value shell_pll {gui_actual_phase_shift0} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift1} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift10} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift11} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift12} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift13} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift14} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift15} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift16} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift17} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift2} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift3} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift4} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift5} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift6} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift7} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift8} {0}
set_instance_parameter_value shell_pll {gui_actual_phase_shift9} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter0} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter1} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter10} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter11} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter12} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter13} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter14} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter15} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter16} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter17} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter2} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter3} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter4} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter5} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter6} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter7} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter8} {0}
set_instance_parameter_value shell_pll {gui_cascade_counter9} {0}
set_instance_parameter_value shell_pll {gui_cascade_outclk_index} {0}
set_instance_parameter_value shell_pll {gui_channel_spacing} {0.0}
set_instance_parameter_value shell_pll {gui_clk_bad} {0}
set_instance_parameter_value shell_pll {gui_device_speed_grade} {2}
set_instance_parameter_value shell_pll {gui_divide_factor_c0} {16}
set_instance_parameter_value shell_pll {gui_divide_factor_c1} {64}
set_instance_parameter_value shell_pll {gui_divide_factor_c10} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c11} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c12} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c13} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c14} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c15} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c16} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c17} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c2} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c3} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c4} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c5} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c6} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c7} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c8} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_c9} {1}
set_instance_parameter_value shell_pll {gui_divide_factor_n} {1}
set_instance_parameter_value shell_pll {gui_dps_cntr} {C0}
set_instance_parameter_value shell_pll {gui_dps_dir} {Positive}
set_instance_parameter_value shell_pll {gui_dps_num} {1}
set_instance_parameter_value shell_pll {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value shell_pll {gui_duty_cycle0} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle1} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle10} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle11} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle12} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle13} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle14} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle15} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle16} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle17} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle2} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle3} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle4} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle5} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle6} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle7} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle8} {50}
set_instance_parameter_value shell_pll {gui_duty_cycle9} {50}
set_instance_parameter_value shell_pll {gui_en_adv_params} {1}
set_instance_parameter_value shell_pll {gui_en_dps_ports} {0}
set_instance_parameter_value shell_pll {gui_en_phout_ports} {0}
set_instance_parameter_value shell_pll {gui_en_reconf} {0}
set_instance_parameter_value shell_pll {gui_enable_cascade_in} {0}
set_instance_parameter_value shell_pll {gui_enable_cascade_out} {0}
set_instance_parameter_value shell_pll {gui_enable_mif_dps} {0}
set_instance_parameter_value shell_pll {gui_feedback_clock} {Global Clock}
set_instance_parameter_value shell_pll {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value shell_pll {gui_fractional_cout} {32}
set_instance_parameter_value shell_pll {gui_mif_generate} {0}
set_instance_parameter_value shell_pll {gui_multiply_factor} {32}
set_instance_parameter_value shell_pll {gui_number_of_clocks} {2}
set_instance_parameter_value shell_pll {gui_operation_mode} {direct}
set_instance_parameter_value shell_pll {gui_output_clock_frequency0} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency1} {25.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency10} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency11} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency12} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency13} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency14} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency15} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency16} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency17} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency2} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency3} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency4} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency5} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency6} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency7} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency8} {100.0}
set_instance_parameter_value shell_pll {gui_output_clock_frequency9} {100.0}
set_instance_parameter_value shell_pll {gui_phase_shift0} {0}
set_instance_parameter_value shell_pll {gui_phase_shift1} {0}
set_instance_parameter_value shell_pll {gui_phase_shift10} {0}
set_instance_parameter_value shell_pll {gui_phase_shift11} {0}
set_instance_parameter_value shell_pll {gui_phase_shift12} {0}
set_instance_parameter_value shell_pll {gui_phase_shift13} {0}
set_instance_parameter_value shell_pll {gui_phase_shift14} {0}
set_instance_parameter_value shell_pll {gui_phase_shift15} {0}
set_instance_parameter_value shell_pll {gui_phase_shift16} {0}
set_instance_parameter_value shell_pll {gui_phase_shift17} {0}
set_instance_parameter_value shell_pll {gui_phase_shift2} {0}
set_instance_parameter_value shell_pll {gui_phase_shift3} {0}
set_instance_parameter_value shell_pll {gui_phase_shift4} {0}
set_instance_parameter_value shell_pll {gui_phase_shift5} {0}
set_instance_parameter_value shell_pll {gui_phase_shift6} {0}
set_instance_parameter_value shell_pll {gui_phase_shift7} {0}
set_instance_parameter_value shell_pll {gui_phase_shift8} {0}
set_instance_parameter_value shell_pll {gui_phase_shift9} {0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg0} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg1} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg10} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg11} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg12} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg13} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg14} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg15} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg16} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg17} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg2} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg3} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg4} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg5} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg6} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg7} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg8} {0.0}
set_instance_parameter_value shell_pll {gui_phase_shift_deg9} {0.0}
set_instance_parameter_value shell_pll {gui_phout_division} {1}
set_instance_parameter_value shell_pll {gui_pll_auto_reset} {Off}
set_instance_parameter_value shell_pll {gui_pll_bandwidth_preset} {Auto}
set_instance_parameter_value shell_pll {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}
set_instance_parameter_value shell_pll {gui_pll_mode} {Integer-N PLL}
set_instance_parameter_value shell_pll {gui_ps_units0} {ps}
set_instance_parameter_value shell_pll {gui_ps_units1} {ps}
set_instance_parameter_value shell_pll {gui_ps_units10} {ps}
set_instance_parameter_value shell_pll {gui_ps_units11} {ps}
set_instance_parameter_value shell_pll {gui_ps_units12} {ps}
set_instance_parameter_value shell_pll {gui_ps_units13} {ps}
set_instance_parameter_value shell_pll {gui_ps_units14} {ps}
set_instance_parameter_value shell_pll {gui_ps_units15} {ps}
set_instance_parameter_value shell_pll {gui_ps_units16} {ps}
set_instance_parameter_value shell_pll {gui_ps_units17} {ps}
set_instance_parameter_value shell_pll {gui_ps_units2} {ps}
set_instance_parameter_value shell_pll {gui_ps_units3} {ps}
set_instance_parameter_value shell_pll {gui_ps_units4} {ps}
set_instance_parameter_value shell_pll {gui_ps_units5} {ps}
set_instance_parameter_value shell_pll {gui_ps_units6} {ps}
set_instance_parameter_value shell_pll {gui_ps_units7} {ps}
set_instance_parameter_value shell_pll {gui_ps_units8} {ps}
set_instance_parameter_value shell_pll {gui_ps_units9} {ps}
set_instance_parameter_value shell_pll {gui_refclk1_frequency} {100.0}
set_instance_parameter_value shell_pll {gui_refclk_switch} {0}
set_instance_parameter_value shell_pll {gui_reference_clock_frequency} {50.0}
set_instance_parameter_value shell_pll {gui_switchover_delay} {0}
set_instance_parameter_value shell_pll {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value shell_pll {gui_use_locked} {0}

add_instance tdc_0 tdk 1.0
set_instance_parameter_value tdc_0 {C_OUT_WIDTH} {128}
set_instance_parameter_value tdc_0 {C_SYNC_DEPTH} {4}
set_instance_parameter_value tdc_0 {REVERSE} {1}
set_instance_parameter_value tdc_0 {TECHNOLOGY} {28nm}

add_instance tdc_reset_pio altera_avalon_pio 22.1
set_instance_parameter_value tdc_reset_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value tdc_reset_pio {bitModifyingOutReg} {0}
set_instance_parameter_value tdc_reset_pio {captureEdge} {0}
set_instance_parameter_value tdc_reset_pio {direction} {Output}
set_instance_parameter_value tdc_reset_pio {edgeType} {RISING}
set_instance_parameter_value tdc_reset_pio {generateIRQ} {0}
set_instance_parameter_value tdc_reset_pio {irqType} {LEVEL}
set_instance_parameter_value tdc_reset_pio {resetValue} {0.0}
set_instance_parameter_value tdc_reset_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value tdc_reset_pio {simDrivenValue} {0.0}
set_instance_parameter_value tdc_reset_pio {width} {32}

add_instance tdc_to_dma_dc_fifo altera_avalon_dc_fifo 22.1
set_instance_parameter_value tdc_to_dma_dc_fifo {BITS_PER_SYMBOL} {8}
set_instance_parameter_value tdc_to_dma_dc_fifo {CHANNEL_WIDTH} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {ENABLE_EXPLICIT_MAXCHANNEL} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {ERROR_WIDTH} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {EXPLICIT_MAXCHANNEL} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {FIFO_DEPTH} {16}
set_instance_parameter_value tdc_to_dma_dc_fifo {RD_SYNC_DEPTH} {8}
set_instance_parameter_value tdc_to_dma_dc_fifo {SYMBOLS_PER_BEAT} {32}
set_instance_parameter_value tdc_to_dma_dc_fifo {USE_IN_FILL_LEVEL} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {USE_OUT_FILL_LEVEL} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {USE_PACKETS} {0}
set_instance_parameter_value tdc_to_dma_dc_fifo {WR_SYNC_DEPTH} {8}

add_instance theta_clks altera_pll 22.1
set_instance_parameter_value theta_clks {debug_print_output} {0}
set_instance_parameter_value theta_clks {debug_use_rbc_taf_method} {0}
set_instance_parameter_value theta_clks {gui_active_clk} {0}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency0} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency1} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency10} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency11} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency12} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency13} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency14} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency15} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency16} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency17} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency2} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency3} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency4} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency5} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency6} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency7} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency8} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_output_clock_frequency9} {0 MHz}
set_instance_parameter_value theta_clks {gui_actual_phase_shift0} {0 ps}
set_instance_parameter_value theta_clks {gui_actual_phase_shift1} {0 ps}
set_instance_parameter_value theta_clks {gui_actual_phase_shift10} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift11} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift12} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift13} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift14} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift15} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift16} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift17} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift2} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift3} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift4} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift5} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift6} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift7} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift8} {0}
set_instance_parameter_value theta_clks {gui_actual_phase_shift9} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter0} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter1} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter10} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter11} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter12} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter13} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter14} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter15} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter16} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter17} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter2} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter3} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter4} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter5} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter6} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter7} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter8} {0}
set_instance_parameter_value theta_clks {gui_cascade_counter9} {0}
set_instance_parameter_value theta_clks {gui_cascade_outclk_index} {0}
set_instance_parameter_value theta_clks {gui_channel_spacing} {0.0}
set_instance_parameter_value theta_clks {gui_clk_bad} {0}
set_instance_parameter_value theta_clks {gui_device_speed_grade} {2}
set_instance_parameter_value theta_clks {gui_divide_factor_c0} {16}
set_instance_parameter_value theta_clks {gui_divide_factor_c1} {16}
set_instance_parameter_value theta_clks {gui_divide_factor_c10} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c11} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c12} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c13} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c14} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c15} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c16} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c17} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c2} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c3} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c4} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c5} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c6} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c7} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c8} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_c9} {1}
set_instance_parameter_value theta_clks {gui_divide_factor_n} {1}
set_instance_parameter_value theta_clks {gui_dps_cntr} {C0}
set_instance_parameter_value theta_clks {gui_dps_dir} {Positive}
set_instance_parameter_value theta_clks {gui_dps_num} {1}
set_instance_parameter_value theta_clks {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value theta_clks {gui_duty_cycle0} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle1} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle10} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle11} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle12} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle13} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle14} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle15} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle16} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle17} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle2} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle3} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle4} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle5} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle6} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle7} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle8} {50}
set_instance_parameter_value theta_clks {gui_duty_cycle9} {50}
set_instance_parameter_value theta_clks {gui_en_adv_params} {1}
set_instance_parameter_value theta_clks {gui_en_dps_ports} {0}
set_instance_parameter_value theta_clks {gui_en_phout_ports} {0}
set_instance_parameter_value theta_clks {gui_en_reconf} {1}
set_instance_parameter_value theta_clks {gui_enable_cascade_in} {1}
set_instance_parameter_value theta_clks {gui_enable_cascade_out} {0}
set_instance_parameter_value theta_clks {gui_enable_mif_dps} {0}
set_instance_parameter_value theta_clks {gui_feedback_clock} {Global Clock}
set_instance_parameter_value theta_clks {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value theta_clks {gui_fractional_cout} {8}
set_instance_parameter_value theta_clks {gui_mif_generate} {0}
set_instance_parameter_value theta_clks {gui_multiply_factor} {32}
set_instance_parameter_value theta_clks {gui_number_of_clocks} {2}
set_instance_parameter_value theta_clks {gui_operation_mode} {normal}
set_instance_parameter_value theta_clks {gui_output_clock_frequency0} {300.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency1} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency10} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency11} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency12} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency13} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency14} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency15} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency16} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency17} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency2} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency3} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency4} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency5} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency6} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency7} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency8} {100.0}
set_instance_parameter_value theta_clks {gui_output_clock_frequency9} {100.0}
set_instance_parameter_value theta_clks {gui_phase_shift0} {0}
set_instance_parameter_value theta_clks {gui_phase_shift1} {0}
set_instance_parameter_value theta_clks {gui_phase_shift10} {0}
set_instance_parameter_value theta_clks {gui_phase_shift11} {0}
set_instance_parameter_value theta_clks {gui_phase_shift12} {0}
set_instance_parameter_value theta_clks {gui_phase_shift13} {0}
set_instance_parameter_value theta_clks {gui_phase_shift14} {0}
set_instance_parameter_value theta_clks {gui_phase_shift15} {0}
set_instance_parameter_value theta_clks {gui_phase_shift16} {0}
set_instance_parameter_value theta_clks {gui_phase_shift17} {0}
set_instance_parameter_value theta_clks {gui_phase_shift2} {0}
set_instance_parameter_value theta_clks {gui_phase_shift3} {0}
set_instance_parameter_value theta_clks {gui_phase_shift4} {0}
set_instance_parameter_value theta_clks {gui_phase_shift5} {0}
set_instance_parameter_value theta_clks {gui_phase_shift6} {0}
set_instance_parameter_value theta_clks {gui_phase_shift7} {0}
set_instance_parameter_value theta_clks {gui_phase_shift8} {0}
set_instance_parameter_value theta_clks {gui_phase_shift9} {0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg0} {164.9}
set_instance_parameter_value theta_clks {gui_phase_shift_deg1} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg10} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg11} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg12} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg13} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg14} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg15} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg16} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg17} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg2} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg3} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg4} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg5} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg6} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg7} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg8} {0.0}
set_instance_parameter_value theta_clks {gui_phase_shift_deg9} {0.0}
set_instance_parameter_value theta_clks {gui_phout_division} {1}
set_instance_parameter_value theta_clks {gui_pll_auto_reset} {Off}
set_instance_parameter_value theta_clks {gui_pll_bandwidth_preset} {High}
set_instance_parameter_value theta_clks {gui_pll_cascading_mode} {Create an adjpllin signal to connect with an upstream PLL}
set_instance_parameter_value theta_clks {gui_pll_mode} {Integer-N PLL}
set_instance_parameter_value theta_clks {gui_ps_units0} {ps}
set_instance_parameter_value theta_clks {gui_ps_units1} {ps}
set_instance_parameter_value theta_clks {gui_ps_units10} {ps}
set_instance_parameter_value theta_clks {gui_ps_units11} {ps}
set_instance_parameter_value theta_clks {gui_ps_units12} {ps}
set_instance_parameter_value theta_clks {gui_ps_units13} {ps}
set_instance_parameter_value theta_clks {gui_ps_units14} {ps}
set_instance_parameter_value theta_clks {gui_ps_units15} {ps}
set_instance_parameter_value theta_clks {gui_ps_units16} {ps}
set_instance_parameter_value theta_clks {gui_ps_units17} {ps}
set_instance_parameter_value theta_clks {gui_ps_units2} {ps}
set_instance_parameter_value theta_clks {gui_ps_units3} {ps}
set_instance_parameter_value theta_clks {gui_ps_units4} {ps}
set_instance_parameter_value theta_clks {gui_ps_units5} {ps}
set_instance_parameter_value theta_clks {gui_ps_units6} {ps}
set_instance_parameter_value theta_clks {gui_ps_units7} {ps}
set_instance_parameter_value theta_clks {gui_ps_units8} {ps}
set_instance_parameter_value theta_clks {gui_ps_units9} {ps}
set_instance_parameter_value theta_clks {gui_refclk1_frequency} {100.0}
set_instance_parameter_value theta_clks {gui_refclk_switch} {0}
set_instance_parameter_value theta_clks {gui_reference_clock_frequency} {50.0}
set_instance_parameter_value theta_clks {gui_switchover_delay} {0}
set_instance_parameter_value theta_clks {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value theta_clks {gui_use_locked} {1}

add_instance theta_locked altera_avalon_pio 22.1
set_instance_parameter_value theta_locked {bitClearingEdgeCapReg} {0}
set_instance_parameter_value theta_locked {bitModifyingOutReg} {0}
set_instance_parameter_value theta_locked {captureEdge} {0}
set_instance_parameter_value theta_locked {direction} {Input}
set_instance_parameter_value theta_locked {edgeType} {RISING}
set_instance_parameter_value theta_locked {generateIRQ} {0}
set_instance_parameter_value theta_locked {irqType} {LEVEL}
set_instance_parameter_value theta_locked {resetValue} {0.0}
set_instance_parameter_value theta_locked {simDoTestBenchWiring} {0}
set_instance_parameter_value theta_locked {simDrivenValue} {0.0}
set_instance_parameter_value theta_locked {width} {32}

add_instance theta_pll_reconfig altera_pll_reconfig 22.1
set_instance_parameter_value theta_pll_reconfig {ENABLE_BYTEENABLE} {0}
set_instance_parameter_value theta_pll_reconfig {ENABLE_MIF} {0}
set_instance_parameter_value theta_pll_reconfig {MIF_FILE_NAME} {}

add_instance theta_pll_reconfig_cdc altera_avalon_mm_clock_crossing_bridge 22.1
set_instance_parameter_value theta_pll_reconfig_cdc {ADDRESS_UNITS} {SYMBOLS}
set_instance_parameter_value theta_pll_reconfig_cdc {ADDRESS_WIDTH} {6}
set_instance_parameter_value theta_pll_reconfig_cdc {COMMAND_FIFO_DEPTH} {8}
set_instance_parameter_value theta_pll_reconfig_cdc {DATA_WIDTH} {32}
set_instance_parameter_value theta_pll_reconfig_cdc {MASTER_SYNC_DEPTH} {8}
set_instance_parameter_value theta_pll_reconfig_cdc {MAX_BURST_SIZE} {1}
set_instance_parameter_value theta_pll_reconfig_cdc {RESPONSE_FIFO_DEPTH} {8}
set_instance_parameter_value theta_pll_reconfig_cdc {SLAVE_SYNC_DEPTH} {8}
set_instance_parameter_value theta_pll_reconfig_cdc {SYMBOL_WIDTH} {8}
set_instance_parameter_value theta_pll_reconfig_cdc {USE_AUTO_ADDRESS_WIDTH} {1}

add_instance theta_pll_reset_bridge altera_reset_controller 22.1
set_instance_parameter_value theta_pll_reset_bridge {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value theta_pll_reset_bridge {NUM_RESET_INPUTS} {1}
set_instance_parameter_value theta_pll_reset_bridge {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value theta_pll_reset_bridge {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value theta_pll_reset_bridge {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value theta_pll_reset_bridge {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value theta_pll_reset_bridge {SYNC_DEPTH} {2}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value theta_pll_reset_bridge {USE_RESET_REQUEST_INPUT} {0}

add_instance theta_pll_reset_pio altera_avalon_pio 22.1
set_instance_parameter_value theta_pll_reset_pio {bitClearingEdgeCapReg} {0}
set_instance_parameter_value theta_pll_reset_pio {bitModifyingOutReg} {0}
set_instance_parameter_value theta_pll_reset_pio {captureEdge} {0}
set_instance_parameter_value theta_pll_reset_pio {direction} {Output}
set_instance_parameter_value theta_pll_reset_pio {edgeType} {RISING}
set_instance_parameter_value theta_pll_reset_pio {generateIRQ} {0}
set_instance_parameter_value theta_pll_reset_pio {irqType} {LEVEL}
set_instance_parameter_value theta_pll_reset_pio {resetValue} {0.0}
set_instance_parameter_value theta_pll_reset_pio {simDoTestBenchWiring} {0}
set_instance_parameter_value theta_pll_reset_pio {simDrivenValue} {0.0}
set_instance_parameter_value theta_pll_reset_pio {width} {32}

# exported interfaces
add_interface aes_reset_in reset sink
set_interface_property aes_reset_in EXPORT_OF aes_reset_controller.reset_in0
add_interface aes_reset_out conduit end
set_interface_property aes_reset_out EXPORT_OF aes_reset_pio.external_connection
add_interface clk clock sink
set_interface_property clk EXPORT_OF input_clk.clk_in
add_interface locked_phi_in conduit end
set_interface_property locked_phi_in EXPORT_OF phi_locked.external_connection
add_interface locked_phi_out conduit end
set_interface_property locked_phi_out EXPORT_OF phi_clk.locked
add_interface locked_theta_in conduit end
set_interface_property locked_theta_in EXPORT_OF theta_locked.external_connection
add_interface locked_theta_out conduit end
set_interface_property locked_theta_out EXPORT_OF theta_clks.locked
add_interface memory conduit end
set_interface_property memory EXPORT_OF hps_0.memory
add_interface reset_phi_in reset sink
set_interface_property reset_phi_in EXPORT_OF phi_pll_reset_bridge.reset_in0
add_interface reset_phi_out conduit end
set_interface_property reset_phi_out EXPORT_OF phi_pll_reset_pio.external_connection
add_interface reset_theta_in reset sink
set_interface_property reset_theta_in EXPORT_OF theta_pll_reset_bridge.reset_in0
add_interface reset_theta_out conduit end
set_interface_property reset_theta_out EXPORT_OF theta_pll_reset_pio.external_connection
add_interface tdc_reset_in reset sink
set_interface_property tdc_reset_in EXPORT_OF reset_bridge_tdc.reset_in0
add_interface tdc_reset_out conduit end
set_interface_property tdc_reset_out EXPORT_OF tdc_reset_pio.external_connection
add_interface theta_clks_refclk clock sink
set_interface_property theta_clks_refclk EXPORT_OF theta_clks.refclk

# connections and connection parameters
add_connection DMA_to_SDRAM.mm_write hps_0.f2h_sdram0_data
set_connection_parameter_value DMA_to_SDRAM.mm_write/hps_0.f2h_sdram0_data arbitrationPriority {1}
set_connection_parameter_value DMA_to_SDRAM.mm_write/hps_0.f2h_sdram0_data baseAddress {0x0000}
set_connection_parameter_value DMA_to_SDRAM.mm_write/hps_0.f2h_sdram0_data defaultConnection {0}

add_connection aes_reset_controller.reset_out aes.reset

add_connection aes_reset_controller.reset_out ip_sync.reset

add_connection aes_reset_controller.reset_out ipsync_bridge.m0_reset

add_connection aes_reset_controller.reset_out ipsync_to_aes_delay.m0_reset

add_connection aes_reset_controller.reset_out ipsync_to_aes_delay.s0_reset

add_connection hps_0.f2h_irq0 DMA_to_SDRAM.csr_irq
set_connection_parameter_value hps_0.f2h_irq0/DMA_to_SDRAM.csr_irq irqNumber {1}

add_connection hps_0.h2f_axi_master aes_reset_pio.s1
set_connection_parameter_value hps_0.h2f_axi_master/aes_reset_pio.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/aes_reset_pio.s1 baseAddress {0x01002000}
set_connection_parameter_value hps_0.h2f_axi_master/aes_reset_pio.s1 defaultConnection {0}

add_connection hps_0.h2f_axi_master ipsync_bridge.s0
set_connection_parameter_value hps_0.h2f_axi_master/ipsync_bridge.s0 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/ipsync_bridge.s0 baseAddress {0x01000c00}
set_connection_parameter_value hps_0.h2f_axi_master/ipsync_bridge.s0 defaultConnection {0}

add_connection hps_0.h2f_axi_master phi_locked.s1
set_connection_parameter_value hps_0.h2f_axi_master/phi_locked.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/phi_locked.s1 baseAddress {0x01000600}
set_connection_parameter_value hps_0.h2f_axi_master/phi_locked.s1 defaultConnection {0}

add_connection hps_0.h2f_axi_master phi_pll_reconfig_cdc.s0
set_connection_parameter_value hps_0.h2f_axi_master/phi_pll_reconfig_cdc.s0 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/phi_pll_reconfig_cdc.s0 baseAddress {0x01000400}
set_connection_parameter_value hps_0.h2f_axi_master/phi_pll_reconfig_cdc.s0 defaultConnection {0}

add_connection hps_0.h2f_axi_master phi_pll_reset_pio.s1
set_connection_parameter_value hps_0.h2f_axi_master/phi_pll_reset_pio.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/phi_pll_reset_pio.s1 baseAddress {0x01000500}
set_connection_parameter_value hps_0.h2f_axi_master/phi_pll_reset_pio.s1 defaultConnection {0}

add_connection hps_0.h2f_axi_master pulsegenerator_cdc.s0
set_connection_parameter_value hps_0.h2f_axi_master/pulsegenerator_cdc.s0 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/pulsegenerator_cdc.s0 baseAddress {0x01001000}
set_connection_parameter_value hps_0.h2f_axi_master/pulsegenerator_cdc.s0 defaultConnection {0}

add_connection hps_0.h2f_axi_master tdc_reset_pio.s1
set_connection_parameter_value hps_0.h2f_axi_master/tdc_reset_pio.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/tdc_reset_pio.s1 baseAddress {0x01000800}
set_connection_parameter_value hps_0.h2f_axi_master/tdc_reset_pio.s1 defaultConnection {0}

add_connection hps_0.h2f_axi_master theta_locked.s1
set_connection_parameter_value hps_0.h2f_axi_master/theta_locked.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/theta_locked.s1 baseAddress {0x01000300}
set_connection_parameter_value hps_0.h2f_axi_master/theta_locked.s1 defaultConnection {0}

add_connection hps_0.h2f_axi_master theta_pll_reconfig_cdc.s0
set_connection_parameter_value hps_0.h2f_axi_master/theta_pll_reconfig_cdc.s0 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/theta_pll_reconfig_cdc.s0 baseAddress {0x01000100}
set_connection_parameter_value hps_0.h2f_axi_master/theta_pll_reconfig_cdc.s0 defaultConnection {0}

add_connection hps_0.h2f_axi_master theta_pll_reset_pio.s1
set_connection_parameter_value hps_0.h2f_axi_master/theta_pll_reset_pio.s1 arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_axi_master/theta_pll_reset_pio.s1 baseAddress {0x01000200}
set_connection_parameter_value hps_0.h2f_axi_master/theta_pll_reset_pio.s1 defaultConnection {0}

add_connection hps_0.h2f_lw_axi_master DMA_to_SDRAM.csr
set_connection_parameter_value hps_0.h2f_lw_axi_master/DMA_to_SDRAM.csr arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_lw_axi_master/DMA_to_SDRAM.csr baseAddress {0x0040}
set_connection_parameter_value hps_0.h2f_lw_axi_master/DMA_to_SDRAM.csr defaultConnection {0}

add_connection hps_0.h2f_lw_axi_master DMA_to_SDRAM.descriptor_slave
set_connection_parameter_value hps_0.h2f_lw_axi_master/DMA_to_SDRAM.descriptor_slave arbitrationPriority {1}
set_connection_parameter_value hps_0.h2f_lw_axi_master/DMA_to_SDRAM.descriptor_slave baseAddress {0x0060}
set_connection_parameter_value hps_0.h2f_lw_axi_master/DMA_to_SDRAM.descriptor_slave defaultConnection {0}

add_connection hps_0.h2f_reset DMA_to_SDRAM.reset_n

add_connection hps_0.h2f_reset aes.reset

add_connection hps_0.h2f_reset aes_reset_pio.reset

add_connection hps_0.h2f_reset input_clk.clk_in_reset

add_connection hps_0.h2f_reset ip_sync.reset

add_connection hps_0.h2f_reset ip_sync_to_pulsegenerator_cdc.in_clk_reset

add_connection hps_0.h2f_reset ip_sync_to_pulsegenerator_cdc.out_clk_reset

add_connection hps_0.h2f_reset ipsync_bridge.m0_reset

add_connection hps_0.h2f_reset ipsync_bridge.s0_reset

add_connection hps_0.h2f_reset ipsync_to_aes_delay.m0_reset

add_connection hps_0.h2f_reset ipsync_to_aes_delay.s0_reset

add_connection hps_0.h2f_reset phi_clk.reset

add_connection hps_0.h2f_reset phi_locked.reset

add_connection hps_0.h2f_reset phi_pll_reconfig.mgmt_reset

add_connection hps_0.h2f_reset phi_pll_reconfig_cdc.m0_reset

add_connection hps_0.h2f_reset phi_pll_reconfig_cdc.s0_reset

add_connection hps_0.h2f_reset phi_pll_reset_pio.reset

add_connection hps_0.h2f_reset pulsegenerator.axi_s_resetn

add_connection hps_0.h2f_reset pulsegenerator_cdc.m0_reset

add_connection hps_0.h2f_reset pulsegenerator_cdc.s0_reset

add_connection hps_0.h2f_reset shell_pll.reset

add_connection hps_0.h2f_reset tdc_0.reset

add_connection hps_0.h2f_reset tdc_reset_pio.reset

add_connection hps_0.h2f_reset tdc_to_dma_dc_fifo.in_clk_reset

add_connection hps_0.h2f_reset tdc_to_dma_dc_fifo.out_clk_reset

add_connection hps_0.h2f_reset theta_clks.reset

add_connection hps_0.h2f_reset theta_locked.reset

add_connection hps_0.h2f_reset theta_pll_reconfig.mgmt_reset

add_connection hps_0.h2f_reset theta_pll_reconfig_cdc.m0_reset

add_connection hps_0.h2f_reset theta_pll_reconfig_cdc.s0_reset

add_connection hps_0.h2f_reset theta_pll_reset_pio.reset

add_connection input_clk.clk phi_clk.refclk

add_connection input_clk.clk phi_pll_reconfig.mgmt_clk

add_connection input_clk.clk phi_pll_reconfig_cdc.m0_clk

add_connection input_clk.clk phi_pll_reset_bridge.clk

add_connection input_clk.clk shell_pll.refclk

add_connection input_clk.clk theta_pll_reconfig.mgmt_clk

add_connection input_clk.clk theta_pll_reconfig_cdc.m0_clk

add_connection input_clk.clk_reset DMA_to_SDRAM.reset_n

add_connection input_clk.clk_reset aes.reset

add_connection input_clk.clk_reset aes_reset_pio.reset

add_connection input_clk.clk_reset ip_sync.reset

add_connection input_clk.clk_reset ip_sync_to_pulsegenerator_cdc.in_clk_reset

add_connection input_clk.clk_reset ip_sync_to_pulsegenerator_cdc.out_clk_reset

add_connection input_clk.clk_reset ipsync_bridge.m0_reset

add_connection input_clk.clk_reset ipsync_bridge.s0_reset

add_connection input_clk.clk_reset ipsync_to_aes_delay.m0_reset

add_connection input_clk.clk_reset ipsync_to_aes_delay.s0_reset

add_connection input_clk.clk_reset phi_clk.reset

add_connection input_clk.clk_reset phi_locked.reset

add_connection input_clk.clk_reset phi_pll_reconfig.mgmt_reset

add_connection input_clk.clk_reset phi_pll_reconfig_cdc.m0_reset

add_connection input_clk.clk_reset phi_pll_reconfig_cdc.s0_reset

add_connection input_clk.clk_reset phi_pll_reset_pio.reset

add_connection input_clk.clk_reset pulsegenerator.axi_s_resetn

add_connection input_clk.clk_reset pulsegenerator_cdc.m0_reset

add_connection input_clk.clk_reset pulsegenerator_cdc.s0_reset

add_connection input_clk.clk_reset tdc_0.reset

add_connection input_clk.clk_reset tdc_reset_pio.reset

add_connection input_clk.clk_reset tdc_to_dma_dc_fifo.in_clk_reset

add_connection input_clk.clk_reset tdc_to_dma_dc_fifo.out_clk_reset

add_connection input_clk.clk_reset theta_clks.reset

add_connection input_clk.clk_reset theta_locked.reset

add_connection input_clk.clk_reset theta_pll_reconfig.mgmt_reset

add_connection input_clk.clk_reset theta_pll_reconfig_cdc.m0_reset

add_connection input_clk.clk_reset theta_pll_reconfig_cdc.s0_reset

add_connection input_clk.clk_reset theta_pll_reset_pio.reset

add_connection ip_sync.avalon_master ipsync_to_aes_delay.s0
set_connection_parameter_value ip_sync.avalon_master/ipsync_to_aes_delay.s0 arbitrationPriority {1}
set_connection_parameter_value ip_sync.avalon_master/ipsync_to_aes_delay.s0 baseAddress {0x0000}
set_connection_parameter_value ip_sync.avalon_master/ipsync_to_aes_delay.s0 defaultConnection {0}

add_connection ip_sync.avalon_streaming_source ip_sync_to_pulsegenerator_cdc.in

add_connection ip_sync_to_pulsegenerator_cdc.out pulsegenerator.avalon_streaming_sink

add_connection ipsync_bridge.m0 ip_sync.avalon_slave
set_connection_parameter_value ipsync_bridge.m0/ip_sync.avalon_slave arbitrationPriority {1}
set_connection_parameter_value ipsync_bridge.m0/ip_sync.avalon_slave baseAddress {0x0000}
set_connection_parameter_value ipsync_bridge.m0/ip_sync.avalon_slave defaultConnection {0}

add_connection ipsync_to_aes_delay.m0 aes.avalon_slave_0_1
set_connection_parameter_value ipsync_to_aes_delay.m0/aes.avalon_slave_0_1 arbitrationPriority {1}
set_connection_parameter_value ipsync_to_aes_delay.m0/aes.avalon_slave_0_1 baseAddress {0x0000}
set_connection_parameter_value ipsync_to_aes_delay.m0/aes.avalon_slave_0_1 defaultConnection {0}

add_connection phi_clk.reconfig_to_pll phi_pll_reconfig.reconfig_to_pll
set_connection_parameter_value phi_clk.reconfig_to_pll/phi_pll_reconfig.reconfig_to_pll endPort {}
set_connection_parameter_value phi_clk.reconfig_to_pll/phi_pll_reconfig.reconfig_to_pll endPortLSB {0}
set_connection_parameter_value phi_clk.reconfig_to_pll/phi_pll_reconfig.reconfig_to_pll startPort {}
set_connection_parameter_value phi_clk.reconfig_to_pll/phi_pll_reconfig.reconfig_to_pll startPortLSB {0}
set_connection_parameter_value phi_clk.reconfig_to_pll/phi_pll_reconfig.reconfig_to_pll width {0}

add_connection phi_pll_reconfig.reconfig_from_pll phi_clk.reconfig_from_pll
set_connection_parameter_value phi_pll_reconfig.reconfig_from_pll/phi_clk.reconfig_from_pll endPort {}
set_connection_parameter_value phi_pll_reconfig.reconfig_from_pll/phi_clk.reconfig_from_pll endPortLSB {0}
set_connection_parameter_value phi_pll_reconfig.reconfig_from_pll/phi_clk.reconfig_from_pll startPort {}
set_connection_parameter_value phi_pll_reconfig.reconfig_from_pll/phi_clk.reconfig_from_pll startPortLSB {0}
set_connection_parameter_value phi_pll_reconfig.reconfig_from_pll/phi_clk.reconfig_from_pll width {0}

add_connection phi_pll_reconfig_cdc.m0 phi_pll_reconfig.mgmt_avalon_slave
set_connection_parameter_value phi_pll_reconfig_cdc.m0/phi_pll_reconfig.mgmt_avalon_slave arbitrationPriority {1}
set_connection_parameter_value phi_pll_reconfig_cdc.m0/phi_pll_reconfig.mgmt_avalon_slave baseAddress {0x0000}
set_connection_parameter_value phi_pll_reconfig_cdc.m0/phi_pll_reconfig.mgmt_avalon_slave defaultConnection {0}

add_connection phi_pll_reset_bridge.reset_out phi_clk.reset

add_connection pulsegenerator.avalon_streaming_source tdc_0.avalon_streaming_sink

add_connection pulsegenerator_cdc.m0 pulsegenerator.altera_axi4lite_slave
set_connection_parameter_value pulsegenerator_cdc.m0/pulsegenerator.altera_axi4lite_slave arbitrationPriority {1}
set_connection_parameter_value pulsegenerator_cdc.m0/pulsegenerator.altera_axi4lite_slave baseAddress {0x0000}
set_connection_parameter_value pulsegenerator_cdc.m0/pulsegenerator.altera_axi4lite_slave defaultConnection {0}

add_connection reset_bridge_capt.reset_out tdc_0.reset

add_connection reset_bridge_capt.reset_out tdc_to_dma_dc_fifo.in_clk_reset

add_connection reset_bridge_launch.reset_out pulsegenerator.axi_s_resetn

add_connection reset_bridge_launch.reset_out pulsegenerator_cdc.m0_reset

add_connection reset_bridge_shell.reset_out pulsegenerator_cdc.s0_reset

add_connection reset_bridge_shell.reset_out tdc_to_dma_dc_fifo.out_clk_reset

add_connection reset_bridge_tdc.reset_out reset_bridge_capt.reset_in0

add_connection reset_bridge_tdc.reset_out reset_bridge_launch.reset_in0

add_connection reset_bridge_tdc.reset_out reset_bridge_shell.reset_in0

add_connection shell_pll.outclk0 DMA_to_SDRAM.clock

add_connection shell_pll.outclk0 aes_reset_pio.clk

add_connection shell_pll.outclk0 hps_0.f2h_sdram0_clock

add_connection shell_pll.outclk0 hps_0.h2f_axi_clock

add_connection shell_pll.outclk0 hps_0.h2f_lw_axi_clock

add_connection shell_pll.outclk0 ipsync_bridge.s0_clk

add_connection shell_pll.outclk0 phi_locked.clk

add_connection shell_pll.outclk0 phi_pll_reconfig_cdc.s0_clk

add_connection shell_pll.outclk0 phi_pll_reset_pio.clk

add_connection shell_pll.outclk0 pulsegenerator_cdc.s0_clk

add_connection shell_pll.outclk0 reset_bridge_shell.clk

add_connection shell_pll.outclk0 reset_bridge_tdc.clk

add_connection shell_pll.outclk0 tdc_reset_pio.clk

add_connection shell_pll.outclk0 tdc_to_dma_dc_fifo.out_clk

add_connection shell_pll.outclk0 theta_locked.clk

add_connection shell_pll.outclk0 theta_pll_reconfig_cdc.s0_clk

add_connection shell_pll.outclk0 theta_pll_reset_bridge.clk

add_connection shell_pll.outclk0 theta_pll_reset_pio.clk

add_connection shell_pll.outclk1 aes.clock

add_connection shell_pll.outclk1 aes_reset_controller.clk

add_connection shell_pll.outclk1 ip_sync.clock

add_connection shell_pll.outclk1 ip_sync_to_pulsegenerator_cdc.in_clk

add_connection shell_pll.outclk1 ipsync_bridge.m0_clk

add_connection shell_pll.outclk1 ipsync_to_aes_delay.m0_clk

add_connection shell_pll.outclk1 ipsync_to_aes_delay.s0_clk

add_connection tdc_0.avalon_streaming_source tdc_to_dma_dc_fifo.in

add_connection tdc_to_dma_dc_fifo.out DMA_to_SDRAM.st_sink

add_connection theta_clks.adjpllin phi_clk.cascade_out
set_connection_parameter_value theta_clks.adjpllin/phi_clk.cascade_out endPort {}
set_connection_parameter_value theta_clks.adjpllin/phi_clk.cascade_out endPortLSB {0}
set_connection_parameter_value theta_clks.adjpllin/phi_clk.cascade_out startPort {}
set_connection_parameter_value theta_clks.adjpllin/phi_clk.cascade_out startPortLSB {0}
set_connection_parameter_value theta_clks.adjpllin/phi_clk.cascade_out width {0}

add_connection theta_clks.outclk0 ip_sync_to_pulsegenerator_cdc.out_clk

add_connection theta_clks.outclk0 pulsegenerator.axi_s_clock

add_connection theta_clks.outclk0 pulsegenerator_cdc.m0_clk

add_connection theta_clks.outclk0 reset_bridge_launch.clk

add_connection theta_clks.outclk0 tdc_0.clk_launch

add_connection theta_clks.outclk1 reset_bridge_capt.clk

add_connection theta_clks.outclk1 tdc_0.clk_capt

add_connection theta_clks.outclk1 tdc_to_dma_dc_fifo.in_clk

add_connection theta_clks.reconfig_from_pll theta_pll_reconfig.reconfig_from_pll
set_connection_parameter_value theta_clks.reconfig_from_pll/theta_pll_reconfig.reconfig_from_pll endPort {}
set_connection_parameter_value theta_clks.reconfig_from_pll/theta_pll_reconfig.reconfig_from_pll endPortLSB {0}
set_connection_parameter_value theta_clks.reconfig_from_pll/theta_pll_reconfig.reconfig_from_pll startPort {}
set_connection_parameter_value theta_clks.reconfig_from_pll/theta_pll_reconfig.reconfig_from_pll startPortLSB {0}
set_connection_parameter_value theta_clks.reconfig_from_pll/theta_pll_reconfig.reconfig_from_pll width {0}

add_connection theta_pll_reconfig.reconfig_to_pll theta_clks.reconfig_to_pll
set_connection_parameter_value theta_pll_reconfig.reconfig_to_pll/theta_clks.reconfig_to_pll endPort {}
set_connection_parameter_value theta_pll_reconfig.reconfig_to_pll/theta_clks.reconfig_to_pll endPortLSB {0}
set_connection_parameter_value theta_pll_reconfig.reconfig_to_pll/theta_clks.reconfig_to_pll startPort {}
set_connection_parameter_value theta_pll_reconfig.reconfig_to_pll/theta_clks.reconfig_to_pll startPortLSB {0}
set_connection_parameter_value theta_pll_reconfig.reconfig_to_pll/theta_clks.reconfig_to_pll width {0}

add_connection theta_pll_reconfig_cdc.m0 theta_pll_reconfig.mgmt_avalon_slave
set_connection_parameter_value theta_pll_reconfig_cdc.m0/theta_pll_reconfig.mgmt_avalon_slave arbitrationPriority {1}
set_connection_parameter_value theta_pll_reconfig_cdc.m0/theta_pll_reconfig.mgmt_avalon_slave baseAddress {0x0000}
set_connection_parameter_value theta_pll_reconfig_cdc.m0/theta_pll_reconfig.mgmt_avalon_slave defaultConnection {0}

add_connection theta_pll_reset_bridge.reset_out theta_clks.reset

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}

save_system {soc_system.qsys}
