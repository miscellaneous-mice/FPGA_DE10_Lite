# Legal Notice: (C)2026 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	signal_analyzer_NIOS_II_cpu 	signal_analyzer_NIOS_II_cpu:*
set 	signal_analyzer_NIOS_II_cpu_oci 	signal_analyzer_NIOS_II_cpu_nios2_oci:the_signal_analyzer_NIOS_II_cpu_nios2_oci
set 	signal_analyzer_NIOS_II_cpu_oci_break 	signal_analyzer_NIOS_II_cpu_nios2_oci_break:the_signal_analyzer_NIOS_II_cpu_nios2_oci_break
set 	signal_analyzer_NIOS_II_cpu_ocimem 	signal_analyzer_NIOS_II_cpu_nios2_ocimem:the_signal_analyzer_NIOS_II_cpu_nios2_ocimem
set 	signal_analyzer_NIOS_II_cpu_oci_debug 	signal_analyzer_NIOS_II_cpu_nios2_oci_debug:the_signal_analyzer_NIOS_II_cpu_nios2_oci_debug
set 	signal_analyzer_NIOS_II_cpu_wrapper 	signal_analyzer_NIOS_II_cpu_debug_slave_wrapper:the_signal_analyzer_NIOS_II_cpu_debug_slave_wrapper
set 	signal_analyzer_NIOS_II_cpu_jtag_tck 	signal_analyzer_NIOS_II_cpu_debug_slave_tck:the_signal_analyzer_NIOS_II_cpu_debug_slave_tck
set 	signal_analyzer_NIOS_II_cpu_jtag_sysclk 	signal_analyzer_NIOS_II_cpu_debug_slave_sysclk:the_signal_analyzer_NIOS_II_cpu_debug_slave_sysclk
set 	signal_analyzer_NIOS_II_cpu_oci_path 	 [format "%s|%s" $signal_analyzer_NIOS_II_cpu $signal_analyzer_NIOS_II_cpu_oci]
set 	signal_analyzer_NIOS_II_cpu_oci_break_path 	 [format "%s|%s" $signal_analyzer_NIOS_II_cpu_oci_path $signal_analyzer_NIOS_II_cpu_oci_break]
set 	signal_analyzer_NIOS_II_cpu_ocimem_path 	 [format "%s|%s" $signal_analyzer_NIOS_II_cpu_oci_path $signal_analyzer_NIOS_II_cpu_ocimem]
set 	signal_analyzer_NIOS_II_cpu_oci_debug_path 	 [format "%s|%s" $signal_analyzer_NIOS_II_cpu_oci_path $signal_analyzer_NIOS_II_cpu_oci_debug]
set 	signal_analyzer_NIOS_II_cpu_jtag_tck_path 	 [format "%s|%s|%s" $signal_analyzer_NIOS_II_cpu_oci_path $signal_analyzer_NIOS_II_cpu_wrapper $signal_analyzer_NIOS_II_cpu_jtag_tck]
set 	signal_analyzer_NIOS_II_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $signal_analyzer_NIOS_II_cpu_oci_path $signal_analyzer_NIOS_II_cpu_wrapper $signal_analyzer_NIOS_II_cpu_jtag_sysclk]
set 	signal_analyzer_NIOS_II_cpu_jtag_sr 	 [format "%s|*sr" $signal_analyzer_NIOS_II_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$signal_analyzer_NIOS_II_cpu_oci_break_path|break_readreg*] -to [get_keepers *$signal_analyzer_NIOS_II_cpu_jtag_sr*]
set_false_path -from [get_keepers *$signal_analyzer_NIOS_II_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$signal_analyzer_NIOS_II_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$signal_analyzer_NIOS_II_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$signal_analyzer_NIOS_II_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$signal_analyzer_NIOS_II_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$signal_analyzer_NIOS_II_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$signal_analyzer_NIOS_II_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$signal_analyzer_NIOS_II_cpu_jtag_sr*]
set_false_path -from *$signal_analyzer_NIOS_II_cpu_jtag_sr*    -to *$signal_analyzer_NIOS_II_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$signal_analyzer_NIOS_II_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$signal_analyzer_NIOS_II_cpu_oci_debug_path|monitor_go
