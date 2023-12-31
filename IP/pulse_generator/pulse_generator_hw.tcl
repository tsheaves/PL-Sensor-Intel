# TCL File Generated by Component Editor 22.1
# Mon Aug 07 23:10:26 PDT 2023
# DO NOT MODIFY


# 
# pulse_generator "pulsegen" v1.0
# Dustin Richmond 2023.08.07.23:10:26
# Pulse generator RTL AXIMM/S
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module pulse_generator
# 
set_module_property DESCRIPTION "Pulse generator RTL AXIMM/S"
set_module_property NAME pulse_generator
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP KRG
set_module_property AUTHOR "Dustin Richmond"
set_module_property DISPLAY_NAME pulsegen
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL pulsegenerator
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file pulsegenerator.v VERILOG PATH ./hdl/pulsegenerator.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter C_SELECT_BIT STD_LOGIC_VECTOR 1
set_parameter_property C_SELECT_BIT DEFAULT_VALUE 1
set_parameter_property C_SELECT_BIT DISPLAY_NAME C_SELECT_BIT
set_parameter_property C_SELECT_BIT WIDTH 4
set_parameter_property C_SELECT_BIT TYPE STD_LOGIC_VECTOR
set_parameter_property C_SELECT_BIT UNITS None
set_parameter_property C_SELECT_BIT ALLOWED_RANGES 0:15
set_parameter_property C_SELECT_BIT HDL_PARAMETER true
add_parameter PIPELINE_OUTPUT INTEGER 2
set_parameter_property PIPELINE_OUTPUT DEFAULT_VALUE 2
set_parameter_property PIPELINE_OUTPUT DISPLAY_NAME PIPELINE_OUTPUT
set_parameter_property PIPELINE_OUTPUT TYPE INTEGER
set_parameter_property PIPELINE_OUTPUT UNITS None
set_parameter_property PIPELINE_OUTPUT ALLOWED_RANGES -2147483648:2147483647
set_parameter_property PIPELINE_OUTPUT HDL_PARAMETER true


# 
# display items
# 


# 
# connection point axi_s_clock
# 
add_interface axi_s_clock clock end
set_interface_property axi_s_clock clockRate 100000000
set_interface_property axi_s_clock ENABLED true
set_interface_property axi_s_clock EXPORT_OF ""
set_interface_property axi_s_clock PORT_NAME_MAP ""
set_interface_property axi_s_clock CMSIS_SVD_VARIABLES ""
set_interface_property axi_s_clock SVD_ADDRESS_GROUP ""

add_interface_port axi_s_clock S_AXI_ACLK clk Input 1


# 
# connection point axi_s_resetn
# 
add_interface axi_s_resetn reset end
set_interface_property axi_s_resetn associatedClock axi_s_clock
set_interface_property axi_s_resetn synchronousEdges DEASSERT
set_interface_property axi_s_resetn ENABLED true
set_interface_property axi_s_resetn EXPORT_OF ""
set_interface_property axi_s_resetn PORT_NAME_MAP ""
set_interface_property axi_s_resetn CMSIS_SVD_VARIABLES ""
set_interface_property axi_s_resetn SVD_ADDRESS_GROUP ""

add_interface_port axi_s_resetn S_AXI_ARESETN reset_n Input 1


# 
# connection point altera_axi4lite_slave
# 
add_interface altera_axi4lite_slave axi4lite end
set_interface_property altera_axi4lite_slave associatedClock axi_s_clock
set_interface_property altera_axi4lite_slave associatedReset axi_s_resetn
set_interface_property altera_axi4lite_slave readAcceptanceCapability 1
set_interface_property altera_axi4lite_slave writeAcceptanceCapability 1
set_interface_property altera_axi4lite_slave combinedAcceptanceCapability 1
set_interface_property altera_axi4lite_slave readDataReorderingDepth 1
set_interface_property altera_axi4lite_slave bridgesToMaster ""
set_interface_property altera_axi4lite_slave ENABLED true
set_interface_property altera_axi4lite_slave EXPORT_OF ""
set_interface_property altera_axi4lite_slave PORT_NAME_MAP ""
set_interface_property altera_axi4lite_slave CMSIS_SVD_VARIABLES ""
set_interface_property altera_axi4lite_slave SVD_ADDRESS_GROUP ""

add_interface_port altera_axi4lite_slave S_AXI_ARADDR araddr Input 4
add_interface_port altera_axi4lite_slave S_AXI_ARREADY arready Output 1
add_interface_port altera_axi4lite_slave S_AXI_ARVALID arvalid Input 1
add_interface_port altera_axi4lite_slave S_AXI_AWADDR awaddr Input 4
add_interface_port altera_axi4lite_slave S_AXI_AWREADY awready Output 1
add_interface_port altera_axi4lite_slave S_AXI_AWVALID awvalid Input 1
add_interface_port altera_axi4lite_slave S_AXI_BREADY bready Input 1
add_interface_port altera_axi4lite_slave S_AXI_BRESP bresp Output 2
add_interface_port altera_axi4lite_slave S_AXI_BVALID bvalid Output 1
add_interface_port altera_axi4lite_slave S_AXI_RDATA rdata Output 32
add_interface_port altera_axi4lite_slave S_AXI_RREADY rready Input 1
add_interface_port altera_axi4lite_slave S_AXI_RRESP rresp Output 2
add_interface_port altera_axi4lite_slave S_AXI_RVALID rvalid Output 1
add_interface_port altera_axi4lite_slave S_AXI_WDATA wdata Input 32
add_interface_port altera_axi4lite_slave S_AXI_WREADY wready Output 1
add_interface_port altera_axi4lite_slave S_AXI_WSTRB wstrb Input 4
add_interface_port altera_axi4lite_slave S_AXI_WVALID wvalid Input 1
add_interface_port altera_axi4lite_slave S_AXI_ARPROT arprot Input 3
add_interface_port altera_axi4lite_slave S_AXI_AWPROT awprot Input 3


# 
# connection point avalon_streaming_source
# 
add_interface avalon_streaming_source avalon_streaming start
set_interface_property avalon_streaming_source associatedClock axi_s_clock
set_interface_property avalon_streaming_source associatedReset axi_s_resetn
set_interface_property avalon_streaming_source dataBitsPerSymbol 8
set_interface_property avalon_streaming_source errorDescriptor ""
set_interface_property avalon_streaming_source firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_source maxChannel 0
set_interface_property avalon_streaming_source readyLatency 0
set_interface_property avalon_streaming_source ENABLED true
set_interface_property avalon_streaming_source EXPORT_OF ""
set_interface_property avalon_streaming_source PORT_NAME_MAP ""
set_interface_property avalon_streaming_source CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_source SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_source M_AVST_DATA data Output 8
add_interface_port avalon_streaming_source M_AVST_VALID valid Output 1
add_interface_port avalon_streaming_source M_AVST_READY ready Input 1


# 
# connection point avalon_streaming_sink
# 
add_interface avalon_streaming_sink avalon_streaming end
set_interface_property avalon_streaming_sink associatedClock axi_s_clock
set_interface_property avalon_streaming_sink associatedReset axi_s_resetn
set_interface_property avalon_streaming_sink dataBitsPerSymbol 8
set_interface_property avalon_streaming_sink errorDescriptor ""
set_interface_property avalon_streaming_sink firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_sink maxChannel 0
set_interface_property avalon_streaming_sink readyLatency 0
set_interface_property avalon_streaming_sink ENABLED true
set_interface_property avalon_streaming_sink EXPORT_OF ""
set_interface_property avalon_streaming_sink PORT_NAME_MAP ""
set_interface_property avalon_streaming_sink CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_sink SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_sink S_AVST_VALID valid Input 1
add_interface_port avalon_streaming_sink S_AVST_DATA data Input 8
add_interface_port avalon_streaming_sink S_AVST_READY ready Output 1

