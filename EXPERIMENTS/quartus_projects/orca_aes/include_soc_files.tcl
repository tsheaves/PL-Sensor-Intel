proc get_env {var_name} {
   global env
   return $env($var_name)
}

set QPROJ_IP [get_env "QPROJ_IP"]

set_global_assignment -name VERILOG_FILE ${QPROJ_IP}/soc_system_common/intr_capturer/intr_capturer.v
set_global_assignment -name VERILOG_FILE ${QPROJ_IP}/soc_system_common/edge_detect/altera_edge_detector.v
set_global_assignment -name VERILOG_FILE ${QPROJ_IP}/soc_system_common/debounce/debounce.v
set_global_assignment -name QIP_FILE ${QPROJ_IP}/soc_system_common/altsource_probe/hps_reset.qip
