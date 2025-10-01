`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2017 11:24:31 PM
// Design Name: 
// Module Name: clock_manager
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      This module is used to supply the clocks and resets to all the other modules as necessary. 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_manager
    #(  
        parameter   FAN_OUT_SW_RST_APPCLK               =   16'd1,
        parameter   FAN_OUT_SW_RST_APPCLK_N             =   16'd1,
        parameter   FAN_OUT_SW_RST_RIUCLK               =   16'd1,
        parameter   FAN_OUT_SW_RST_RIUCLK_N             =   16'd1
    )
    (
    input   clk_100m_p,          //External differential clock - 100MHz
            clk_100m_n,
            hw_rst_n,           //Harware reset active_low
            sw_rst,             //Reset given through S/W
            app_clk,            //app_clk - derived from the IP
    
    output  riu_clk,            //free running riu_clk           
            [FAN_OUT_SW_RST_APPCLK-1 : 0]            sw_rst_appclk,   
            [FAN_OUT_SW_RST_APPCLK_N-1 : 0]          sw_rst_appclk_n,           //appclk synchronised negedge resets
            [FAN_OUT_SW_RST_RIUCLK-1 : 0]            sw_rst_riuclk,   
            [FAN_OUT_SW_RST_RIUCLK_N-1 : 0]          sw_rst_riuclk_n            //riuclk synchronised negedge resets
    );
    
    wire    hw_rst,
            dac_ref_clk_out;
    
    assign  hw_rst  =   !hw_rst_n;
    
    mmcm_1 riu_clk_mmcm
    (   // Clock out ports
        .riu_clk        (riu_clk),          // output riu_clk_out
        // Clock in ports
        .clk_in1_p      (clk_100m_p),        // input clk_in1_p
        .clk_in1_n      (clk_100m_n));       // input clk_in1_n
    
    reset_sync #(.SYNC_RST_POLARITY("ACTIVE_HIGH"),.SYNC_STAGES(2),.FAN_OUT(FAN_OUT_SW_RST_APPCLK))
    reset_sync_i0   (
       .clk            (app_clk),
       .rst            (sw_rst),
       .sync_clk_rst   (sw_rst_appclk)
       );
    reset_sync #(.SYNC_RST_POLARITY("ACTIVE_LOW"),.SYNC_STAGES(2),.FAN_OUT(FAN_OUT_SW_RST_APPCLK_N))
    reset_sync_i1   (
       .clk            (app_clk),
       .rst            (!sw_rst),
       .sync_clk_rst   (sw_rst_appclk_n)
       );
    
    reset_sync #(.SYNC_RST_POLARITY("ACTIVE_HIGH"),.SYNC_STAGES(2),.FAN_OUT(FAN_OUT_SW_RST_RIUCLK))
    reset_sync_i2   (
       .clk            (riu_clk),
       .rst            (sw_rst),
       .sync_clk_rst   (sw_rst_riuclk)
       );
    reset_sync #(.SYNC_RST_POLARITY("ACTIVE_LOW"),.SYNC_STAGES(2),.FAN_OUT(FAN_OUT_SW_RST_RIUCLK_N))
    reset_sync_i3   (
       .clk            (riu_clk),
       .rst            (!sw_rst),
       .sync_clk_rst   (sw_rst_riuclk_n)
       );
endmodule
