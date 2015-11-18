## Generated SDC file "mp3.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.1.4 Build 182 03/12/2014 SJ Full Version"

## DATE    "Tue Nov 17 20:18:32 2015"

##
## DEVICE  "EP4CGX22CF19C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 10.000 -waveform { 0.000 5.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {clk}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[8]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[9]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[10]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[11]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[12]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[13]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[14]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata1[15]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[8]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[9]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[10]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[11]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[12]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[13]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[14]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_rdata2[15]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {resp_a}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {resp_b}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[12]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[13]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[14]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr1[15]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[12]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[13]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[14]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_addr2[15]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_byte_enable2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_byte_enable2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_read1}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_read2}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[12]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[13]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[14]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_wdata2[15]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {mem_write2}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

