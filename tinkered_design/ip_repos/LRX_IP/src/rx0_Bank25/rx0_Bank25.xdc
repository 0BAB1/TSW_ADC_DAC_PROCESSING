# file: rx0_Bank25.xdc
# (c) Copyright 2013 - 2015 Xilinx, Inc. All rights reserved.
# 
# This file contains confidential and proprietary information
# of Xilinx, Inc. and is protected under U.S. and
# international copyright and other intellectual property
# laws.
# 
# DISCLAIMER
# This disclaimer is not a license and does not grant any
# rights to the materials distributed herewith. Except as
# otherwise provided in a valid license issued to you by
# Xilinx, and to the maximum extent permitted by applicable
# law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
# WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
# AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
# BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
# INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
# (2) Xilinx shall not be liable (whether in contract or tort,
# including negligence, or under any other theory of
# liability) for any loss or damage of any kind or nature
# related to, arising under or in connection with these
# materials, including for any direct, or any indirect,
# special, incidental, or consequential loss or damage
# (including loss of data, profits, goodwill, or any type of
# loss or damage suffered as a result of any action brought
# by a third party) even if such damage or loss was
# reasonably foreseeable or Xilinx had been advised of the
# possibility of the same.
# 
# CRITICAL APPLICATIONS
# Xilinx products are not designed or intended to be fail-
# safe, or for use in any application requiring fail-safe
# performance, such as life-support or safety devices or
# systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any
# other applications that could lead to death, personal
# injury, or severe property or environmental damage
# (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and
# liability of any use of Xilinx products in Critical
# Applications, subject only to applicable laws and
# regulations governing limitations on product liability.
# 
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
# PART OF THIS FILE AT ALL TIMES.
set_false_path -to [get_pins -hier *sync_flop_0*/D]

########### Set the DIfferential IO standard from the supported Differential IO standards###############
set diff_std LVDS


set_property PACKAGE_PIN  AP36 [get_ports clk_p]
set_property PACKAGE_PIN  AR36 [get_ports clk_n]
set_property DATA_RATE DDR [get_ports  clk_p]
set_property DATA_RATE DDR [get_ports  clk_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  clk_p]
set_property IOSTANDARD $diff_std [get_ports  clk_n]
######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AW33 [get_ports rx_data7_p]
set_property DATA_RATE DDR [get_ports rx_data7_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data7_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AW34 [get_ports rx_data7_n]
set_property DATA_RATE DDR [get_ports rx_data7_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data7_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AT35 [get_ports rx_data8_p]
set_property DATA_RATE DDR [get_ports rx_data8_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data8_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AU35 [get_ports rx_data8_n]
set_property DATA_RATE DDR [get_ports rx_data8_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data8_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AU36 [get_ports rx_data10_p]
set_property DATA_RATE DDR [get_ports rx_data10_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data10_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AV36 [get_ports rx_data10_n]
set_property DATA_RATE DDR [get_ports rx_data10_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data10_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AV38 [get_ports rx_data5_p]
set_property DATA_RATE DDR [get_ports rx_data5_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data5_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AV39 [get_ports rx_data5_n]
set_property DATA_RATE DDR [get_ports rx_data5_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data5_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AU37 [get_ports rx_data6_p]
set_property DATA_RATE DDR [get_ports rx_data6_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data6_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AV37 [get_ports rx_data6_n]
set_property DATA_RATE DDR [get_ports rx_data6_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data6_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AT39 [get_ports rx_data11_p]
set_property DATA_RATE DDR [get_ports rx_data11_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data11_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AU39 [get_ports rx_data11_n]
set_property DATA_RATE DDR [get_ports rx_data11_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data11_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AR37 [get_ports rx_data4_p]
set_property DATA_RATE DDR [get_ports rx_data4_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data4_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AT37 [get_ports rx_data4_n]
set_property DATA_RATE DDR [get_ports rx_data4_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data4_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AR38 [get_ports rx_data1_p]
set_property DATA_RATE DDR [get_ports rx_data1_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data1_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AT38 [get_ports rx_data1_n]
set_property DATA_RATE DDR [get_ports rx_data1_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data1_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AN36 [get_ports strobe_rx_p]
set_property DATA_RATE DDR [get_ports strobe_rx_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  strobe_rx_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AN37 [get_ports strobe_rx_n]
set_property DATA_RATE DDR [get_ports strobe_rx_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  strobe_rx_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AN38 [get_ports rx_data2_p]
set_property DATA_RATE DDR [get_ports rx_data2_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data2_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AP38 [get_ports rx_data2_n]
set_property DATA_RATE DDR [get_ports rx_data2_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data2_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AM34 [get_ports rx_data9_p]
set_property DATA_RATE DDR [get_ports rx_data9_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data9_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AM35 [get_ports rx_data9_n]
set_property DATA_RATE DDR [get_ports rx_data9_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data9_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AN39 [get_ports rx_data3_p]
set_property DATA_RATE DDR [get_ports rx_data3_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data3_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AP39 [get_ports rx_data3_n]
set_property DATA_RATE DDR [get_ports rx_data3_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data3_n]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AM36 [get_ports rx_data0_p]
set_property DATA_RATE DDR [get_ports rx_data0_p]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data0_p]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN AM37 [get_ports rx_data0_n]
set_property DATA_RATE DDR [get_ports rx_data0_n]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  rx_data0_n]















set_property PHASESHIFT_MODE WAVEFORM [get_cells -hierarchical *plle*]
########### Use the below mentioned constraints to fix Timing Violations on Bitslice Inputs###############
#set_property -name CLKOUT0_PHASE -value -90.000 -objects [get_cells *_inst/inst/top_inst/clk_rst_top_inst/clk_scheme_inst/plle3_adv_pll0_inst]
#set_multicycle_path -from [get_clocks -of_objects [get_pins *_inst/inst/top_inst/clk_rst_top_inst/clk_scheme_inst/plle3_adv_pll0_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins *_inst/inst/top_inst/bs_ctrl_top_inst/BITSLICE_CTRL*.bs_ctrl_inst/*_BIT_CTRL_OUT*]] 2

