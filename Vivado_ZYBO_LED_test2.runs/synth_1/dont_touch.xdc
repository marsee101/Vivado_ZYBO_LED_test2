# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: imports/new/Vivado_ZYBO_LED_test.xdc

# Block Designs: bd/Vivado_ZYBO_LED_test/Vivado_ZYBO_LED_test.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test || ORIG_REF_NAME==Vivado_ZYBO_LED_test}]

# IP: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_processing_system7_0_0/Vivado_ZYBO_LED_test_processing_system7_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_processing_system7_0_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_processing_system7_0_0}]

# IP: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_led4_axi_lite_slave_0_0/Vivado_ZYBO_LED_test_led4_axi_lite_slave_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_led4_axi_lite_slave_0_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_led4_axi_lite_slave_0_0}]

# IP: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_processing_system7_0_axi_periph_0/Vivado_ZYBO_LED_test_processing_system7_0_axi_periph_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_processing_system7_0_axi_periph_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_processing_system7_0_axi_periph_0}]

# IP: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0}]

# IP: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_auto_pc_0/Vivado_ZYBO_LED_test_auto_pc_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_auto_pc_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_auto_pc_0}]

# XDC: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_processing_system7_0_0/Vivado_ZYBO_LED_test_processing_system7_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_processing_system7_0_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_processing_system7_0_0}] {/inst }]/inst ]]

# XDC: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0}] {/U0 }]/U0 ]]

# XDC: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0_ooc.xdc

# XDC: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0_board.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0}] {/U0 }]/U0 ]]

# XDC: bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_auto_pc_0/Vivado_ZYBO_LED_test_auto_pc_0_ooc.xdc

# XDC: bd/Vivado_ZYBO_LED_test/Vivado_ZYBO_LED_test_ooc.xdc
