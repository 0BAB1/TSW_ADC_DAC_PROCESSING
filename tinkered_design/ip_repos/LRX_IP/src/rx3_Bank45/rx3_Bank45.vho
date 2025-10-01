-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:high_speed_selectio_wiz:3.2
-- IP Revision: 0

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT rx3_Bank45
  PORT (
    rx_cntvaluein_0 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_0 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_0 : IN STD_LOGIC;
    rx_inc_0 : IN STD_LOGIC;
    rx_load_0 : IN STD_LOGIC;
    rx_en_vtc_0 : IN STD_LOGIC;
    rx_cntvaluein_2 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_2 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_2 : IN STD_LOGIC;
    rx_inc_2 : IN STD_LOGIC;
    rx_load_2 : IN STD_LOGIC;
    rx_en_vtc_2 : IN STD_LOGIC;
    rx_cntvaluein_10 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_10 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_10 : IN STD_LOGIC;
    rx_inc_10 : IN STD_LOGIC;
    rx_load_10 : IN STD_LOGIC;
    rx_en_vtc_10 : IN STD_LOGIC;
    rx_cntvaluein_13 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_13 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_13 : IN STD_LOGIC;
    rx_inc_13 : IN STD_LOGIC;
    rx_load_13 : IN STD_LOGIC;
    rx_en_vtc_13 : IN STD_LOGIC;
    rx_cntvaluein_15 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_15 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_15 : IN STD_LOGIC;
    rx_inc_15 : IN STD_LOGIC;
    rx_load_15 : IN STD_LOGIC;
    rx_en_vtc_15 : IN STD_LOGIC;
    rx_cntvaluein_17 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_17 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_17 : IN STD_LOGIC;
    rx_inc_17 : IN STD_LOGIC;
    rx_load_17 : IN STD_LOGIC;
    rx_en_vtc_17 : IN STD_LOGIC;
    rx_cntvaluein_19 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_19 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_19 : IN STD_LOGIC;
    rx_inc_19 : IN STD_LOGIC;
    rx_load_19 : IN STD_LOGIC;
    rx_en_vtc_19 : IN STD_LOGIC;
    rx_cntvaluein_23 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_23 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_23 : IN STD_LOGIC;
    rx_inc_23 : IN STD_LOGIC;
    rx_load_23 : IN STD_LOGIC;
    rx_en_vtc_23 : IN STD_LOGIC;
    rx_cntvaluein_28 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_28 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_28 : IN STD_LOGIC;
    rx_inc_28 : IN STD_LOGIC;
    rx_load_28 : IN STD_LOGIC;
    rx_en_vtc_28 : IN STD_LOGIC;
    rx_cntvaluein_30 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_30 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_30 : IN STD_LOGIC;
    rx_inc_30 : IN STD_LOGIC;
    rx_load_30 : IN STD_LOGIC;
    rx_en_vtc_30 : IN STD_LOGIC;
    rx_cntvaluein_32 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_32 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_32 : IN STD_LOGIC;
    rx_inc_32 : IN STD_LOGIC;
    rx_load_32 : IN STD_LOGIC;
    rx_en_vtc_32 : IN STD_LOGIC;
    rx_cntvaluein_34 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_34 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_34 : IN STD_LOGIC;
    rx_inc_34 : IN STD_LOGIC;
    rx_load_34 : IN STD_LOGIC;
    rx_en_vtc_34 : IN STD_LOGIC;
    rx_cntvaluein_36 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_cntvalueout_36 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    rx_ce_36 : IN STD_LOGIC;
    rx_inc_36 : IN STD_LOGIC;
    rx_load_36 : IN STD_LOGIC;
    rx_en_vtc_36 : IN STD_LOGIC;
    rx_clk : IN STD_LOGIC;
    fifo_rd_clk_0 : IN STD_LOGIC;
    fifo_rd_clk_2 : IN STD_LOGIC;
    fifo_rd_clk_10 : IN STD_LOGIC;
    fifo_rd_clk_13 : IN STD_LOGIC;
    fifo_rd_clk_15 : IN STD_LOGIC;
    fifo_rd_clk_17 : IN STD_LOGIC;
    fifo_rd_clk_19 : IN STD_LOGIC;
    fifo_rd_clk_23 : IN STD_LOGIC;
    fifo_rd_clk_28 : IN STD_LOGIC;
    fifo_rd_clk_30 : IN STD_LOGIC;
    fifo_rd_clk_32 : IN STD_LOGIC;
    fifo_rd_clk_34 : IN STD_LOGIC;
    fifo_rd_clk_36 : IN STD_LOGIC;
    fifo_rd_en_0 : IN STD_LOGIC;
    fifo_rd_en_2 : IN STD_LOGIC;
    fifo_rd_en_10 : IN STD_LOGIC;
    fifo_rd_en_13 : IN STD_LOGIC;
    fifo_rd_en_15 : IN STD_LOGIC;
    fifo_rd_en_17 : IN STD_LOGIC;
    fifo_rd_en_19 : IN STD_LOGIC;
    fifo_rd_en_23 : IN STD_LOGIC;
    fifo_rd_en_28 : IN STD_LOGIC;
    fifo_rd_en_30 : IN STD_LOGIC;
    fifo_rd_en_32 : IN STD_LOGIC;
    fifo_rd_en_34 : IN STD_LOGIC;
    fifo_rd_en_36 : IN STD_LOGIC;
    fifo_empty_0 : OUT STD_LOGIC;
    fifo_empty_2 : OUT STD_LOGIC;
    fifo_empty_10 : OUT STD_LOGIC;
    fifo_empty_13 : OUT STD_LOGIC;
    fifo_empty_15 : OUT STD_LOGIC;
    fifo_empty_17 : OUT STD_LOGIC;
    fifo_empty_19 : OUT STD_LOGIC;
    fifo_empty_23 : OUT STD_LOGIC;
    fifo_empty_28 : OUT STD_LOGIC;
    fifo_empty_30 : OUT STD_LOGIC;
    fifo_empty_32 : OUT STD_LOGIC;
    fifo_empty_34 : OUT STD_LOGIC;
    fifo_empty_36 : OUT STD_LOGIC;
    riu_rd_data_bg0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    riu_valid_bg0 : OUT STD_LOGIC;
    riu_addr_bg0 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    riu_nibble_sel_bg0 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    riu_wr_data_bg0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    riu_wr_en_bg0 : IN STD_LOGIC;
    riu_rd_data_bg1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    riu_valid_bg1 : OUT STD_LOGIC;
    riu_addr_bg1 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    riu_nibble_sel_bg1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    riu_wr_data_bg1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    riu_wr_en_bg1 : IN STD_LOGIC;
    riu_rd_data_bg2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    riu_valid_bg2 : OUT STD_LOGIC;
    riu_addr_bg2 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    riu_nibble_sel_bg2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    riu_wr_data_bg2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    riu_wr_en_bg2 : IN STD_LOGIC;
    vtc_rdy_bsc0 : OUT STD_LOGIC;
    en_vtc_bsc0 : IN STD_LOGIC;
    vtc_rdy_bsc1 : OUT STD_LOGIC;
    en_vtc_bsc1 : IN STD_LOGIC;
    vtc_rdy_bsc2 : OUT STD_LOGIC;
    en_vtc_bsc2 : IN STD_LOGIC;
    vtc_rdy_bsc3 : OUT STD_LOGIC;
    en_vtc_bsc3 : IN STD_LOGIC;
    vtc_rdy_bsc4 : OUT STD_LOGIC;
    en_vtc_bsc4 : IN STD_LOGIC;
    vtc_rdy_bsc5 : OUT STD_LOGIC;
    en_vtc_bsc5 : IN STD_LOGIC;
    dly_rdy_bsc0 : OUT STD_LOGIC;
    dly_rdy_bsc1 : OUT STD_LOGIC;
    dly_rdy_bsc2 : OUT STD_LOGIC;
    dly_rdy_bsc3 : OUT STD_LOGIC;
    dly_rdy_bsc4 : OUT STD_LOGIC;
    dly_rdy_bsc5 : OUT STD_LOGIC;
    rst_seq_done : OUT STD_LOGIC;
    shared_pll0_clkoutphy_out : OUT STD_LOGIC;
    app_clk : IN STD_LOGIC;
    multi_intf_lock_in : IN STD_LOGIC;
    intf_rdy : OUT STD_LOGIC;
    pll0_clkout0 : OUT STD_LOGIC;
    rst : IN STD_LOGIC;
    clk_p : IN STD_LOGIC;
    clk_n : IN STD_LOGIC;
    riu_clk : IN STD_LOGIC;
    pll0_locked : OUT STD_LOGIC;
    rx_data5_p : IN STD_LOGIC;
    data_to_fabric_rx_data5_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data5_n : IN STD_LOGIC;
    rx_data7_p : IN STD_LOGIC;
    data_to_fabric_rx_data7_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data7_n : IN STD_LOGIC;
    rx_data6_p : IN STD_LOGIC;
    data_to_fabric_rx_data6_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data6_n : IN STD_LOGIC;
    rx_data0_p : IN STD_LOGIC;
    data_to_fabric_rx_data0_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data0_n : IN STD_LOGIC;
    rx_data11_p : IN STD_LOGIC;
    data_to_fabric_rx_data11_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data11_n : IN STD_LOGIC;
    rx_data8_p : IN STD_LOGIC;
    data_to_fabric_rx_data8_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data8_n : IN STD_LOGIC;
    rx_data9_p : IN STD_LOGIC;
    data_to_fabric_rx_data9_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data9_n : IN STD_LOGIC;
    rx_data10_p : IN STD_LOGIC;
    data_to_fabric_rx_data10_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data10_n : IN STD_LOGIC;
    strobe_rx_p : IN STD_LOGIC;
    data_to_fabric_strobe_rx_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    strobe_rx_n : IN STD_LOGIC;
    rx_data3_p : IN STD_LOGIC;
    data_to_fabric_rx_data3_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data3_n : IN STD_LOGIC;
    rx_data2_p : IN STD_LOGIC;
    data_to_fabric_rx_data2_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data2_n : IN STD_LOGIC;
    rx_data1_p : IN STD_LOGIC;
    data_to_fabric_rx_data1_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data1_n : IN STD_LOGIC;
    rx_data4_p : IN STD_LOGIC;
    data_to_fabric_rx_data4_p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_data4_n : IN STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : rx3_Bank45
  PORT MAP (
    rx_cntvaluein_0 => rx_cntvaluein_0,
    rx_cntvalueout_0 => rx_cntvalueout_0,
    rx_ce_0 => rx_ce_0,
    rx_inc_0 => rx_inc_0,
    rx_load_0 => rx_load_0,
    rx_en_vtc_0 => rx_en_vtc_0,
    rx_cntvaluein_2 => rx_cntvaluein_2,
    rx_cntvalueout_2 => rx_cntvalueout_2,
    rx_ce_2 => rx_ce_2,
    rx_inc_2 => rx_inc_2,
    rx_load_2 => rx_load_2,
    rx_en_vtc_2 => rx_en_vtc_2,
    rx_cntvaluein_10 => rx_cntvaluein_10,
    rx_cntvalueout_10 => rx_cntvalueout_10,
    rx_ce_10 => rx_ce_10,
    rx_inc_10 => rx_inc_10,
    rx_load_10 => rx_load_10,
    rx_en_vtc_10 => rx_en_vtc_10,
    rx_cntvaluein_13 => rx_cntvaluein_13,
    rx_cntvalueout_13 => rx_cntvalueout_13,
    rx_ce_13 => rx_ce_13,
    rx_inc_13 => rx_inc_13,
    rx_load_13 => rx_load_13,
    rx_en_vtc_13 => rx_en_vtc_13,
    rx_cntvaluein_15 => rx_cntvaluein_15,
    rx_cntvalueout_15 => rx_cntvalueout_15,
    rx_ce_15 => rx_ce_15,
    rx_inc_15 => rx_inc_15,
    rx_load_15 => rx_load_15,
    rx_en_vtc_15 => rx_en_vtc_15,
    rx_cntvaluein_17 => rx_cntvaluein_17,
    rx_cntvalueout_17 => rx_cntvalueout_17,
    rx_ce_17 => rx_ce_17,
    rx_inc_17 => rx_inc_17,
    rx_load_17 => rx_load_17,
    rx_en_vtc_17 => rx_en_vtc_17,
    rx_cntvaluein_19 => rx_cntvaluein_19,
    rx_cntvalueout_19 => rx_cntvalueout_19,
    rx_ce_19 => rx_ce_19,
    rx_inc_19 => rx_inc_19,
    rx_load_19 => rx_load_19,
    rx_en_vtc_19 => rx_en_vtc_19,
    rx_cntvaluein_23 => rx_cntvaluein_23,
    rx_cntvalueout_23 => rx_cntvalueout_23,
    rx_ce_23 => rx_ce_23,
    rx_inc_23 => rx_inc_23,
    rx_load_23 => rx_load_23,
    rx_en_vtc_23 => rx_en_vtc_23,
    rx_cntvaluein_28 => rx_cntvaluein_28,
    rx_cntvalueout_28 => rx_cntvalueout_28,
    rx_ce_28 => rx_ce_28,
    rx_inc_28 => rx_inc_28,
    rx_load_28 => rx_load_28,
    rx_en_vtc_28 => rx_en_vtc_28,
    rx_cntvaluein_30 => rx_cntvaluein_30,
    rx_cntvalueout_30 => rx_cntvalueout_30,
    rx_ce_30 => rx_ce_30,
    rx_inc_30 => rx_inc_30,
    rx_load_30 => rx_load_30,
    rx_en_vtc_30 => rx_en_vtc_30,
    rx_cntvaluein_32 => rx_cntvaluein_32,
    rx_cntvalueout_32 => rx_cntvalueout_32,
    rx_ce_32 => rx_ce_32,
    rx_inc_32 => rx_inc_32,
    rx_load_32 => rx_load_32,
    rx_en_vtc_32 => rx_en_vtc_32,
    rx_cntvaluein_34 => rx_cntvaluein_34,
    rx_cntvalueout_34 => rx_cntvalueout_34,
    rx_ce_34 => rx_ce_34,
    rx_inc_34 => rx_inc_34,
    rx_load_34 => rx_load_34,
    rx_en_vtc_34 => rx_en_vtc_34,
    rx_cntvaluein_36 => rx_cntvaluein_36,
    rx_cntvalueout_36 => rx_cntvalueout_36,
    rx_ce_36 => rx_ce_36,
    rx_inc_36 => rx_inc_36,
    rx_load_36 => rx_load_36,
    rx_en_vtc_36 => rx_en_vtc_36,
    rx_clk => rx_clk,
    fifo_rd_clk_0 => fifo_rd_clk_0,
    fifo_rd_clk_2 => fifo_rd_clk_2,
    fifo_rd_clk_10 => fifo_rd_clk_10,
    fifo_rd_clk_13 => fifo_rd_clk_13,
    fifo_rd_clk_15 => fifo_rd_clk_15,
    fifo_rd_clk_17 => fifo_rd_clk_17,
    fifo_rd_clk_19 => fifo_rd_clk_19,
    fifo_rd_clk_23 => fifo_rd_clk_23,
    fifo_rd_clk_28 => fifo_rd_clk_28,
    fifo_rd_clk_30 => fifo_rd_clk_30,
    fifo_rd_clk_32 => fifo_rd_clk_32,
    fifo_rd_clk_34 => fifo_rd_clk_34,
    fifo_rd_clk_36 => fifo_rd_clk_36,
    fifo_rd_en_0 => fifo_rd_en_0,
    fifo_rd_en_2 => fifo_rd_en_2,
    fifo_rd_en_10 => fifo_rd_en_10,
    fifo_rd_en_13 => fifo_rd_en_13,
    fifo_rd_en_15 => fifo_rd_en_15,
    fifo_rd_en_17 => fifo_rd_en_17,
    fifo_rd_en_19 => fifo_rd_en_19,
    fifo_rd_en_23 => fifo_rd_en_23,
    fifo_rd_en_28 => fifo_rd_en_28,
    fifo_rd_en_30 => fifo_rd_en_30,
    fifo_rd_en_32 => fifo_rd_en_32,
    fifo_rd_en_34 => fifo_rd_en_34,
    fifo_rd_en_36 => fifo_rd_en_36,
    fifo_empty_0 => fifo_empty_0,
    fifo_empty_2 => fifo_empty_2,
    fifo_empty_10 => fifo_empty_10,
    fifo_empty_13 => fifo_empty_13,
    fifo_empty_15 => fifo_empty_15,
    fifo_empty_17 => fifo_empty_17,
    fifo_empty_19 => fifo_empty_19,
    fifo_empty_23 => fifo_empty_23,
    fifo_empty_28 => fifo_empty_28,
    fifo_empty_30 => fifo_empty_30,
    fifo_empty_32 => fifo_empty_32,
    fifo_empty_34 => fifo_empty_34,
    fifo_empty_36 => fifo_empty_36,
    riu_rd_data_bg0 => riu_rd_data_bg0,
    riu_valid_bg0 => riu_valid_bg0,
    riu_addr_bg0 => riu_addr_bg0,
    riu_nibble_sel_bg0 => riu_nibble_sel_bg0,
    riu_wr_data_bg0 => riu_wr_data_bg0,
    riu_wr_en_bg0 => riu_wr_en_bg0,
    riu_rd_data_bg1 => riu_rd_data_bg1,
    riu_valid_bg1 => riu_valid_bg1,
    riu_addr_bg1 => riu_addr_bg1,
    riu_nibble_sel_bg1 => riu_nibble_sel_bg1,
    riu_wr_data_bg1 => riu_wr_data_bg1,
    riu_wr_en_bg1 => riu_wr_en_bg1,
    riu_rd_data_bg2 => riu_rd_data_bg2,
    riu_valid_bg2 => riu_valid_bg2,
    riu_addr_bg2 => riu_addr_bg2,
    riu_nibble_sel_bg2 => riu_nibble_sel_bg2,
    riu_wr_data_bg2 => riu_wr_data_bg2,
    riu_wr_en_bg2 => riu_wr_en_bg2,
    vtc_rdy_bsc0 => vtc_rdy_bsc0,
    en_vtc_bsc0 => en_vtc_bsc0,
    vtc_rdy_bsc1 => vtc_rdy_bsc1,
    en_vtc_bsc1 => en_vtc_bsc1,
    vtc_rdy_bsc2 => vtc_rdy_bsc2,
    en_vtc_bsc2 => en_vtc_bsc2,
    vtc_rdy_bsc3 => vtc_rdy_bsc3,
    en_vtc_bsc3 => en_vtc_bsc3,
    vtc_rdy_bsc4 => vtc_rdy_bsc4,
    en_vtc_bsc4 => en_vtc_bsc4,
    vtc_rdy_bsc5 => vtc_rdy_bsc5,
    en_vtc_bsc5 => en_vtc_bsc5,
    dly_rdy_bsc0 => dly_rdy_bsc0,
    dly_rdy_bsc1 => dly_rdy_bsc1,
    dly_rdy_bsc2 => dly_rdy_bsc2,
    dly_rdy_bsc3 => dly_rdy_bsc3,
    dly_rdy_bsc4 => dly_rdy_bsc4,
    dly_rdy_bsc5 => dly_rdy_bsc5,
    rst_seq_done => rst_seq_done,
    shared_pll0_clkoutphy_out => shared_pll0_clkoutphy_out,
    app_clk => app_clk,
    multi_intf_lock_in => multi_intf_lock_in,
    intf_rdy => intf_rdy,
    pll0_clkout0 => pll0_clkout0,
    rst => rst,
    clk_p => clk_p,
    clk_n => clk_n,
    riu_clk => riu_clk,
    pll0_locked => pll0_locked,
    rx_data5_p => rx_data5_p,
    data_to_fabric_rx_data5_p => data_to_fabric_rx_data5_p,
    rx_data5_n => rx_data5_n,
    rx_data7_p => rx_data7_p,
    data_to_fabric_rx_data7_p => data_to_fabric_rx_data7_p,
    rx_data7_n => rx_data7_n,
    rx_data6_p => rx_data6_p,
    data_to_fabric_rx_data6_p => data_to_fabric_rx_data6_p,
    rx_data6_n => rx_data6_n,
    rx_data0_p => rx_data0_p,
    data_to_fabric_rx_data0_p => data_to_fabric_rx_data0_p,
    rx_data0_n => rx_data0_n,
    rx_data11_p => rx_data11_p,
    data_to_fabric_rx_data11_p => data_to_fabric_rx_data11_p,
    rx_data11_n => rx_data11_n,
    rx_data8_p => rx_data8_p,
    data_to_fabric_rx_data8_p => data_to_fabric_rx_data8_p,
    rx_data8_n => rx_data8_n,
    rx_data9_p => rx_data9_p,
    data_to_fabric_rx_data9_p => data_to_fabric_rx_data9_p,
    rx_data9_n => rx_data9_n,
    rx_data10_p => rx_data10_p,
    data_to_fabric_rx_data10_p => data_to_fabric_rx_data10_p,
    rx_data10_n => rx_data10_n,
    strobe_rx_p => strobe_rx_p,
    data_to_fabric_strobe_rx_p => data_to_fabric_strobe_rx_p,
    strobe_rx_n => strobe_rx_n,
    rx_data3_p => rx_data3_p,
    data_to_fabric_rx_data3_p => data_to_fabric_rx_data3_p,
    rx_data3_n => rx_data3_n,
    rx_data2_p => rx_data2_p,
    data_to_fabric_rx_data2_p => data_to_fabric_rx_data2_p,
    rx_data2_n => rx_data2_n,
    rx_data1_p => rx_data1_p,
    data_to_fabric_rx_data1_p => data_to_fabric_rx_data1_p,
    rx_data1_n => rx_data1_n,
    rx_data4_p => rx_data4_p,
    data_to_fabric_rx_data4_p => data_to_fabric_rx_data4_p,
    rx_data4_n => rx_data4_n
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file rx3_Bank45.vhd when simulating
-- the core, rx3_Bank45. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

