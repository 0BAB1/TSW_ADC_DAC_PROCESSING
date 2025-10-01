// (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:ip:high_speed_selectio_wiz:3.2
// IP Revision: 0

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
rx0_Bank25 your_instance_name (
  .rx_cntvaluein_0(rx_cntvaluein_0),                        // input wire [8 : 0] rx_cntvaluein_0
  .rx_cntvalueout_0(rx_cntvalueout_0),                      // output wire [8 : 0] rx_cntvalueout_0
  .rx_ce_0(rx_ce_0),                                        // input wire rx_ce_0
  .rx_inc_0(rx_inc_0),                                      // input wire rx_inc_0
  .rx_load_0(rx_load_0),                                    // input wire rx_load_0
  .rx_en_vtc_0(rx_en_vtc_0),                                // input wire rx_en_vtc_0
  .rx_cntvaluein_10(rx_cntvaluein_10),                      // input wire [8 : 0] rx_cntvaluein_10
  .rx_cntvalueout_10(rx_cntvalueout_10),                    // output wire [8 : 0] rx_cntvalueout_10
  .rx_ce_10(rx_ce_10),                                      // input wire rx_ce_10
  .rx_inc_10(rx_inc_10),                                    // input wire rx_inc_10
  .rx_load_10(rx_load_10),                                  // input wire rx_load_10
  .rx_en_vtc_10(rx_en_vtc_10),                              // input wire rx_en_vtc_10
  .rx_cntvaluein_13(rx_cntvaluein_13),                      // input wire [8 : 0] rx_cntvaluein_13
  .rx_cntvalueout_13(rx_cntvalueout_13),                    // output wire [8 : 0] rx_cntvalueout_13
  .rx_ce_13(rx_ce_13),                                      // input wire rx_ce_13
  .rx_inc_13(rx_inc_13),                                    // input wire rx_inc_13
  .rx_load_13(rx_load_13),                                  // input wire rx_load_13
  .rx_en_vtc_13(rx_en_vtc_13),                              // input wire rx_en_vtc_13
  .rx_cntvaluein_15(rx_cntvaluein_15),                      // input wire [8 : 0] rx_cntvaluein_15
  .rx_cntvalueout_15(rx_cntvalueout_15),                    // output wire [8 : 0] rx_cntvalueout_15
  .rx_ce_15(rx_ce_15),                                      // input wire rx_ce_15
  .rx_inc_15(rx_inc_15),                                    // input wire rx_inc_15
  .rx_load_15(rx_load_15),                                  // input wire rx_load_15
  .rx_en_vtc_15(rx_en_vtc_15),                              // input wire rx_en_vtc_15
  .rx_cntvaluein_17(rx_cntvaluein_17),                      // input wire [8 : 0] rx_cntvaluein_17
  .rx_cntvalueout_17(rx_cntvalueout_17),                    // output wire [8 : 0] rx_cntvalueout_17
  .rx_ce_17(rx_ce_17),                                      // input wire rx_ce_17
  .rx_inc_17(rx_inc_17),                                    // input wire rx_inc_17
  .rx_load_17(rx_load_17),                                  // input wire rx_load_17
  .rx_en_vtc_17(rx_en_vtc_17),                              // input wire rx_en_vtc_17
  .rx_cntvaluein_19(rx_cntvaluein_19),                      // input wire [8 : 0] rx_cntvaluein_19
  .rx_cntvalueout_19(rx_cntvalueout_19),                    // output wire [8 : 0] rx_cntvalueout_19
  .rx_ce_19(rx_ce_19),                                      // input wire rx_ce_19
  .rx_inc_19(rx_inc_19),                                    // input wire rx_inc_19
  .rx_load_19(rx_load_19),                                  // input wire rx_load_19
  .rx_en_vtc_19(rx_en_vtc_19),                              // input wire rx_en_vtc_19
  .rx_cntvaluein_21(rx_cntvaluein_21),                      // input wire [8 : 0] rx_cntvaluein_21
  .rx_cntvalueout_21(rx_cntvalueout_21),                    // output wire [8 : 0] rx_cntvalueout_21
  .rx_ce_21(rx_ce_21),                                      // input wire rx_ce_21
  .rx_inc_21(rx_inc_21),                                    // input wire rx_inc_21
  .rx_load_21(rx_load_21),                                  // input wire rx_load_21
  .rx_en_vtc_21(rx_en_vtc_21),                              // input wire rx_en_vtc_21
  .rx_cntvaluein_23(rx_cntvaluein_23),                      // input wire [8 : 0] rx_cntvaluein_23
  .rx_cntvalueout_23(rx_cntvalueout_23),                    // output wire [8 : 0] rx_cntvalueout_23
  .rx_ce_23(rx_ce_23),                                      // input wire rx_ce_23
  .rx_inc_23(rx_inc_23),                                    // input wire rx_inc_23
  .rx_load_23(rx_load_23),                                  // input wire rx_load_23
  .rx_en_vtc_23(rx_en_vtc_23),                              // input wire rx_en_vtc_23
  .rx_cntvaluein_28(rx_cntvaluein_28),                      // input wire [8 : 0] rx_cntvaluein_28
  .rx_cntvalueout_28(rx_cntvalueout_28),                    // output wire [8 : 0] rx_cntvalueout_28
  .rx_ce_28(rx_ce_28),                                      // input wire rx_ce_28
  .rx_inc_28(rx_inc_28),                                    // input wire rx_inc_28
  .rx_load_28(rx_load_28),                                  // input wire rx_load_28
  .rx_en_vtc_28(rx_en_vtc_28),                              // input wire rx_en_vtc_28
  .rx_cntvaluein_32(rx_cntvaluein_32),                      // input wire [8 : 0] rx_cntvaluein_32
  .rx_cntvalueout_32(rx_cntvalueout_32),                    // output wire [8 : 0] rx_cntvalueout_32
  .rx_ce_32(rx_ce_32),                                      // input wire rx_ce_32
  .rx_inc_32(rx_inc_32),                                    // input wire rx_inc_32
  .rx_load_32(rx_load_32),                                  // input wire rx_load_32
  .rx_en_vtc_32(rx_en_vtc_32),                              // input wire rx_en_vtc_32
  .rx_cntvaluein_34(rx_cntvaluein_34),                      // input wire [8 : 0] rx_cntvaluein_34
  .rx_cntvalueout_34(rx_cntvalueout_34),                    // output wire [8 : 0] rx_cntvalueout_34
  .rx_ce_34(rx_ce_34),                                      // input wire rx_ce_34
  .rx_inc_34(rx_inc_34),                                    // input wire rx_inc_34
  .rx_load_34(rx_load_34),                                  // input wire rx_load_34
  .rx_en_vtc_34(rx_en_vtc_34),                              // input wire rx_en_vtc_34
  .rx_cntvaluein_36(rx_cntvaluein_36),                      // input wire [8 : 0] rx_cntvaluein_36
  .rx_cntvalueout_36(rx_cntvalueout_36),                    // output wire [8 : 0] rx_cntvalueout_36
  .rx_ce_36(rx_ce_36),                                      // input wire rx_ce_36
  .rx_inc_36(rx_inc_36),                                    // input wire rx_inc_36
  .rx_load_36(rx_load_36),                                  // input wire rx_load_36
  .rx_en_vtc_36(rx_en_vtc_36),                              // input wire rx_en_vtc_36
  .rx_cntvaluein_39(rx_cntvaluein_39),                      // input wire [8 : 0] rx_cntvaluein_39
  .rx_cntvalueout_39(rx_cntvalueout_39),                    // output wire [8 : 0] rx_cntvalueout_39
  .rx_ce_39(rx_ce_39),                                      // input wire rx_ce_39
  .rx_inc_39(rx_inc_39),                                    // input wire rx_inc_39
  .rx_load_39(rx_load_39),                                  // input wire rx_load_39
  .rx_en_vtc_39(rx_en_vtc_39),                              // input wire rx_en_vtc_39
  .rx_clk(rx_clk),                                          // input wire rx_clk
  .fifo_rd_clk_0(fifo_rd_clk_0),                            // input wire fifo_rd_clk_0
  .fifo_rd_clk_10(fifo_rd_clk_10),                          // input wire fifo_rd_clk_10
  .fifo_rd_clk_13(fifo_rd_clk_13),                          // input wire fifo_rd_clk_13
  .fifo_rd_clk_15(fifo_rd_clk_15),                          // input wire fifo_rd_clk_15
  .fifo_rd_clk_17(fifo_rd_clk_17),                          // input wire fifo_rd_clk_17
  .fifo_rd_clk_19(fifo_rd_clk_19),                          // input wire fifo_rd_clk_19
  .fifo_rd_clk_21(fifo_rd_clk_21),                          // input wire fifo_rd_clk_21
  .fifo_rd_clk_23(fifo_rd_clk_23),                          // input wire fifo_rd_clk_23
  .fifo_rd_clk_28(fifo_rd_clk_28),                          // input wire fifo_rd_clk_28
  .fifo_rd_clk_32(fifo_rd_clk_32),                          // input wire fifo_rd_clk_32
  .fifo_rd_clk_34(fifo_rd_clk_34),                          // input wire fifo_rd_clk_34
  .fifo_rd_clk_36(fifo_rd_clk_36),                          // input wire fifo_rd_clk_36
  .fifo_rd_clk_39(fifo_rd_clk_39),                          // input wire fifo_rd_clk_39
  .fifo_rd_en_0(fifo_rd_en_0),                              // input wire fifo_rd_en_0
  .fifo_rd_en_10(fifo_rd_en_10),                            // input wire fifo_rd_en_10
  .fifo_rd_en_13(fifo_rd_en_13),                            // input wire fifo_rd_en_13
  .fifo_rd_en_15(fifo_rd_en_15),                            // input wire fifo_rd_en_15
  .fifo_rd_en_17(fifo_rd_en_17),                            // input wire fifo_rd_en_17
  .fifo_rd_en_19(fifo_rd_en_19),                            // input wire fifo_rd_en_19
  .fifo_rd_en_21(fifo_rd_en_21),                            // input wire fifo_rd_en_21
  .fifo_rd_en_23(fifo_rd_en_23),                            // input wire fifo_rd_en_23
  .fifo_rd_en_28(fifo_rd_en_28),                            // input wire fifo_rd_en_28
  .fifo_rd_en_32(fifo_rd_en_32),                            // input wire fifo_rd_en_32
  .fifo_rd_en_34(fifo_rd_en_34),                            // input wire fifo_rd_en_34
  .fifo_rd_en_36(fifo_rd_en_36),                            // input wire fifo_rd_en_36
  .fifo_rd_en_39(fifo_rd_en_39),                            // input wire fifo_rd_en_39
  .fifo_empty_0(fifo_empty_0),                              // output wire fifo_empty_0
  .fifo_empty_10(fifo_empty_10),                            // output wire fifo_empty_10
  .fifo_empty_13(fifo_empty_13),                            // output wire fifo_empty_13
  .fifo_empty_15(fifo_empty_15),                            // output wire fifo_empty_15
  .fifo_empty_17(fifo_empty_17),                            // output wire fifo_empty_17
  .fifo_empty_19(fifo_empty_19),                            // output wire fifo_empty_19
  .fifo_empty_21(fifo_empty_21),                            // output wire fifo_empty_21
  .fifo_empty_23(fifo_empty_23),                            // output wire fifo_empty_23
  .fifo_empty_28(fifo_empty_28),                            // output wire fifo_empty_28
  .fifo_empty_32(fifo_empty_32),                            // output wire fifo_empty_32
  .fifo_empty_34(fifo_empty_34),                            // output wire fifo_empty_34
  .fifo_empty_36(fifo_empty_36),                            // output wire fifo_empty_36
  .fifo_empty_39(fifo_empty_39),                            // output wire fifo_empty_39
  .riu_rd_data_bg0(riu_rd_data_bg0),                        // output wire [15 : 0] riu_rd_data_bg0
  .riu_valid_bg0(riu_valid_bg0),                            // output wire riu_valid_bg0
  .riu_addr_bg0(riu_addr_bg0),                              // input wire [5 : 0] riu_addr_bg0
  .riu_nibble_sel_bg0(riu_nibble_sel_bg0),                  // input wire [1 : 0] riu_nibble_sel_bg0
  .riu_wr_data_bg0(riu_wr_data_bg0),                        // input wire [15 : 0] riu_wr_data_bg0
  .riu_wr_en_bg0(riu_wr_en_bg0),                            // input wire riu_wr_en_bg0
  .riu_rd_data_bg1(riu_rd_data_bg1),                        // output wire [15 : 0] riu_rd_data_bg1
  .riu_valid_bg1(riu_valid_bg1),                            // output wire riu_valid_bg1
  .riu_addr_bg1(riu_addr_bg1),                              // input wire [5 : 0] riu_addr_bg1
  .riu_nibble_sel_bg1(riu_nibble_sel_bg1),                  // input wire [1 : 0] riu_nibble_sel_bg1
  .riu_wr_data_bg1(riu_wr_data_bg1),                        // input wire [15 : 0] riu_wr_data_bg1
  .riu_wr_en_bg1(riu_wr_en_bg1),                            // input wire riu_wr_en_bg1
  .riu_rd_data_bg2(riu_rd_data_bg2),                        // output wire [15 : 0] riu_rd_data_bg2
  .riu_valid_bg2(riu_valid_bg2),                            // output wire riu_valid_bg2
  .riu_addr_bg2(riu_addr_bg2),                              // input wire [5 : 0] riu_addr_bg2
  .riu_nibble_sel_bg2(riu_nibble_sel_bg2),                  // input wire [1 : 0] riu_nibble_sel_bg2
  .riu_wr_data_bg2(riu_wr_data_bg2),                        // input wire [15 : 0] riu_wr_data_bg2
  .riu_wr_en_bg2(riu_wr_en_bg2),                            // input wire riu_wr_en_bg2
  .riu_rd_data_bg3(riu_rd_data_bg3),                        // output wire [15 : 0] riu_rd_data_bg3
  .riu_valid_bg3(riu_valid_bg3),                            // output wire riu_valid_bg3
  .riu_addr_bg3(riu_addr_bg3),                              // input wire [5 : 0] riu_addr_bg3
  .riu_nibble_sel_bg3(riu_nibble_sel_bg3),                  // input wire [1 : 0] riu_nibble_sel_bg3
  .riu_wr_data_bg3(riu_wr_data_bg3),                        // input wire [15 : 0] riu_wr_data_bg3
  .riu_wr_en_bg3(riu_wr_en_bg3),                            // input wire riu_wr_en_bg3
  .vtc_rdy_bsc0(vtc_rdy_bsc0),                              // output wire vtc_rdy_bsc0
  .en_vtc_bsc0(en_vtc_bsc0),                                // input wire en_vtc_bsc0
  .vtc_rdy_bsc1(vtc_rdy_bsc1),                              // output wire vtc_rdy_bsc1
  .en_vtc_bsc1(en_vtc_bsc1),                                // input wire en_vtc_bsc1
  .vtc_rdy_bsc2(vtc_rdy_bsc2),                              // output wire vtc_rdy_bsc2
  .en_vtc_bsc2(en_vtc_bsc2),                                // input wire en_vtc_bsc2
  .vtc_rdy_bsc3(vtc_rdy_bsc3),                              // output wire vtc_rdy_bsc3
  .en_vtc_bsc3(en_vtc_bsc3),                                // input wire en_vtc_bsc3
  .vtc_rdy_bsc4(vtc_rdy_bsc4),                              // output wire vtc_rdy_bsc4
  .en_vtc_bsc4(en_vtc_bsc4),                                // input wire en_vtc_bsc4
  .vtc_rdy_bsc5(vtc_rdy_bsc5),                              // output wire vtc_rdy_bsc5
  .en_vtc_bsc5(en_vtc_bsc5),                                // input wire en_vtc_bsc5
  .vtc_rdy_bsc6(vtc_rdy_bsc6),                              // output wire vtc_rdy_bsc6
  .en_vtc_bsc6(en_vtc_bsc6),                                // input wire en_vtc_bsc6
  .dly_rdy_bsc0(dly_rdy_bsc0),                              // output wire dly_rdy_bsc0
  .dly_rdy_bsc1(dly_rdy_bsc1),                              // output wire dly_rdy_bsc1
  .dly_rdy_bsc2(dly_rdy_bsc2),                              // output wire dly_rdy_bsc2
  .dly_rdy_bsc3(dly_rdy_bsc3),                              // output wire dly_rdy_bsc3
  .dly_rdy_bsc4(dly_rdy_bsc4),                              // output wire dly_rdy_bsc4
  .dly_rdy_bsc5(dly_rdy_bsc5),                              // output wire dly_rdy_bsc5
  .dly_rdy_bsc6(dly_rdy_bsc6),                              // output wire dly_rdy_bsc6
  .rst_seq_done(rst_seq_done),                              // output wire rst_seq_done
  .shared_pll0_clkoutphy_out(shared_pll0_clkoutphy_out),    // output wire shared_pll0_clkoutphy_out
  .app_clk(app_clk),                                        // input wire app_clk
  .multi_intf_lock_in(multi_intf_lock_in),                  // input wire multi_intf_lock_in
  .intf_rdy(intf_rdy),                                      // output wire intf_rdy
  .pll0_clkout0(pll0_clkout0),                              // output wire pll0_clkout0
  .rst(rst),                                                // input wire rst
  .clk_p(clk_p),                                            // input wire clk_p
  .clk_n(clk_n),                                            // input wire clk_n
  .riu_clk(riu_clk),                                        // input wire riu_clk
  .pll0_locked(pll0_locked),                                // output wire pll0_locked
  .rx_data7_p(rx_data7_p),                                  // input wire rx_data7_p
  .data_to_fabric_rx_data7_p(data_to_fabric_rx_data7_p),    // output wire [7 : 0] data_to_fabric_rx_data7_p
  .rx_data7_n(rx_data7_n),                                  // input wire rx_data7_n
  .rx_data8_p(rx_data8_p),                                  // input wire rx_data8_p
  .data_to_fabric_rx_data8_p(data_to_fabric_rx_data8_p),    // output wire [7 : 0] data_to_fabric_rx_data8_p
  .rx_data8_n(rx_data8_n),                                  // input wire rx_data8_n
  .rx_data10_p(rx_data10_p),                                // input wire rx_data10_p
  .data_to_fabric_rx_data10_p(data_to_fabric_rx_data10_p),  // output wire [7 : 0] data_to_fabric_rx_data10_p
  .rx_data10_n(rx_data10_n),                                // input wire rx_data10_n
  .rx_data5_p(rx_data5_p),                                  // input wire rx_data5_p
  .data_to_fabric_rx_data5_p(data_to_fabric_rx_data5_p),    // output wire [7 : 0] data_to_fabric_rx_data5_p
  .rx_data5_n(rx_data5_n),                                  // input wire rx_data5_n
  .rx_data6_p(rx_data6_p),                                  // input wire rx_data6_p
  .data_to_fabric_rx_data6_p(data_to_fabric_rx_data6_p),    // output wire [7 : 0] data_to_fabric_rx_data6_p
  .rx_data6_n(rx_data6_n),                                  // input wire rx_data6_n
  .rx_data11_p(rx_data11_p),                                // input wire rx_data11_p
  .data_to_fabric_rx_data11_p(data_to_fabric_rx_data11_p),  // output wire [7 : 0] data_to_fabric_rx_data11_p
  .rx_data11_n(rx_data11_n),                                // input wire rx_data11_n
  .rx_data4_p(rx_data4_p),                                  // input wire rx_data4_p
  .data_to_fabric_rx_data4_p(data_to_fabric_rx_data4_p),    // output wire [7 : 0] data_to_fabric_rx_data4_p
  .rx_data4_n(rx_data4_n),                                  // input wire rx_data4_n
  .rx_data1_p(rx_data1_p),                                  // input wire rx_data1_p
  .data_to_fabric_rx_data1_p(data_to_fabric_rx_data1_p),    // output wire [7 : 0] data_to_fabric_rx_data1_p
  .rx_data1_n(rx_data1_n),                                  // input wire rx_data1_n
  .strobe_rx_p(strobe_rx_p),                                // input wire strobe_rx_p
  .data_to_fabric_strobe_rx_p(data_to_fabric_strobe_rx_p),  // output wire [7 : 0] data_to_fabric_strobe_rx_p
  .strobe_rx_n(strobe_rx_n),                                // input wire strobe_rx_n
  .rx_data2_p(rx_data2_p),                                  // input wire rx_data2_p
  .data_to_fabric_rx_data2_p(data_to_fabric_rx_data2_p),    // output wire [7 : 0] data_to_fabric_rx_data2_p
  .rx_data2_n(rx_data2_n),                                  // input wire rx_data2_n
  .rx_data9_p(rx_data9_p),                                  // input wire rx_data9_p
  .data_to_fabric_rx_data9_p(data_to_fabric_rx_data9_p),    // output wire [7 : 0] data_to_fabric_rx_data9_p
  .rx_data9_n(rx_data9_n),                                  // input wire rx_data9_n
  .rx_data3_p(rx_data3_p),                                  // input wire rx_data3_p
  .data_to_fabric_rx_data3_p(data_to_fabric_rx_data3_p),    // output wire [7 : 0] data_to_fabric_rx_data3_p
  .rx_data3_n(rx_data3_n),                                  // input wire rx_data3_n
  .rx_data0_p(rx_data0_p),                                  // input wire rx_data0_p
  .data_to_fabric_rx_data0_p(data_to_fabric_rx_data0_p),    // output wire [7 : 0] data_to_fabric_rx_data0_p
  .rx_data0_n(rx_data0_n)                                  // input wire rx_data0_n
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file rx0_Bank25.v when simulating
// the core, rx0_Bank25. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

