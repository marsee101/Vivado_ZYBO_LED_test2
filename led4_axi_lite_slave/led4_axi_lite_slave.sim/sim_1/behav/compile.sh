#!/bin/sh
# Vivado(TM)
# compile.sh: Vivado-generated Script for launching XSim application
# Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
# 
if [ -z "$PATH" ]; then
  PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%:C:/HDL/Xilinx/SDK/2013.4/bin/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/nt64
else
  PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%:C:/HDL/Xilinx/SDK/2013.4/bin/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/nt64;C:/HDL/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/nt64:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=:
else
  LD_LIBRARY_PATH=::$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

#
# Setup env for Xilinx simulation libraries
#
XILINX_PLANAHEAD=C:/HDL/Xilinx/Vivado/2013.4
export XILINX_PLANAHEAD
ExecStep()
{
   "$@"
   RETVAL=$?
   if [ $RETVAL -ne 0 ]
   then
       exit $RETVAL
   fi
}

ExecStep xelab -m64 --debug typical --relax -L work -L unisims_ver -L unimacro_ver -L secureip --snapshot led4_axi_lite_slave_tb_behav --prj C:/Users/Masaaki/Documents/Vivado/Zynq/ZYBO/IP_test/led4_axi_lite_slave/led4_axi_lite_slave.sim/sim_1/behav/led4_axi_lite_slave_tb.prj   work.led4_axi_lite_slave_tb   work.glbl
