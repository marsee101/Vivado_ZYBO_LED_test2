proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.data/wt [current_project]
  set_property parent.project_dir C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2 [current_project]
  add_files C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.runs/synth_1/Vivado_ZYBO_LED_test_wrapper.dcp
  read_xdc -ref Vivado_ZYBO_LED_test_processing_system7_0_0 -cells inst c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_processing_system7_0_0/Vivado_ZYBO_LED_test_processing_system7_0_0.xdc
  read_xdc -ref Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0 -cells U0 c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0.xdc
  read_xdc -prop_thru_buffers -ref Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0 -cells U0 c:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/sources_1/bd/Vivado_ZYBO_LED_test/ip/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0/Vivado_ZYBO_LED_test_rst_processing_system7_0_100M_0_board.xdc
  read_xdc C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/Vivado_ZYBO_LED_test2/Vivado_ZYBO_LED_test2.srcs/constrs_1/imports/new/Vivado_ZYBO_LED_test.xdc
  link_design -top Vivado_ZYBO_LED_test_wrapper -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force Vivado_ZYBO_LED_test_wrapper_opt.dcp
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  catch { report_io -file Vivado_ZYBO_LED_test_wrapper_io_placed.rpt }
  catch { report_clock_utilization -file Vivado_ZYBO_LED_test_wrapper_clock_utilization_placed.rpt }
  catch { report_utilization -file Vivado_ZYBO_LED_test_wrapper_utilization_placed.rpt -pb Vivado_ZYBO_LED_test_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file Vivado_ZYBO_LED_test_wrapper_control_sets_placed.rpt }
  write_checkpoint -force Vivado_ZYBO_LED_test_wrapper_placed.dcp
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  catch { report_drc -file Vivado_ZYBO_LED_test_wrapper_drc_routed.rpt -pb Vivado_ZYBO_LED_test_wrapper_drc_routed.pb }
  catch { report_power -file Vivado_ZYBO_LED_test_wrapper_power_routed.rpt -pb Vivado_ZYBO_LED_test_wrapper_power_summary_routed.pb }
  catch { report_route_status -file Vivado_ZYBO_LED_test_wrapper_route_status.rpt -pb Vivado_ZYBO_LED_test_wrapper_route_status.pb }
  catch { report_timing_summary -file Vivado_ZYBO_LED_test_wrapper_timing_summary_routed.rpt -pb Vivado_ZYBO_LED_test_wrapper_timing_summary_routed.pb }
  write_checkpoint -force Vivado_ZYBO_LED_test_wrapper_routed.dcp
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force Vivado_ZYBO_LED_test_wrapper.bit 
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

