## Generated SDC file "image_filtering.out.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

## DATE    "Fri Feb 11 22:51:33 2022"

##
## DEVICE  "EP4CE22F17C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clock_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clock_50}]
create_clock -name {cam_clk} -period 40.000 -waveform { 0.000 20.000 } [get_ports {cam_clk}]

#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {inst9|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst9|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 47 -divide_by 98 -master_clock {clock_50} [get_pins {inst9|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {inst9|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {inst9|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 141 -divide_by 280 -master_clock {clock_50} [get_pins {inst9|altpll_component|auto_generated|pll1|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {inst9|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {cam_clk}] -rise_to [get_clocks {cam_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {cam_clk}] -fall_to [get_clocks {cam_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {cam_clk}] -rise_to [get_clocks {cam_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {cam_clk}] -fall_to [get_clocks {cam_clk}]  0.020  



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



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

