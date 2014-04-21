# 
# Synthesis run script generated by Vivado
# 

  set_param gui.test TreeTableDev
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1
set_property target_language Verilog [current_project]
set_param project.compositeFile.enableAutoGeneration 0
set_property ip_repo_paths C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/led4_axi_lite_slave [current_fileset]

add_files C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/Vivado_ZYBO_LED_test.bd
set_property used_in_implementation false [get_files -all c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_processing_system7_0_0/Vivado_ZYBO_LED_test_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_auto_pc_0/Vivado_ZYBO_LED_test_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/Vivado_ZYBO_LED_test_ooc.xdc]
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property is_locked true [get_files C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/Vivado_ZYBO_LED_test.bd]

read_verilog C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/hdl/Vivado_ZYBO_LED_test_wrapper.v
read_xdc C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/constrs_1/imports/new/Vivado_ZYBO_LED_test.xdc
set_property used_in_implementation false [get_files C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/constrs_1/imports/new/Vivado_ZYBO_LED_test.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.data/wt [current_project]
set_property parent.project_dir C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2 [current_project]
synth_design -top Vivado_ZYBO_LED_test_wrapper -part xc7z010clg400-1
write_checkpoint Vivado_ZYBO_LED_test_wrapper.dcp
report_utilization -file Vivado_ZYBO_LED_test_wrapper_utilization_synth.rpt -pb Vivado_ZYBO_LED_test_wrapper_utilization_synth.pb
