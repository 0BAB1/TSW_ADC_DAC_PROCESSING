`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2017 04:55:07 PM
// Design Name: 
// Module Name: reset_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reset_sync 
    #(parameter SYNC_RST_POLARITY   = "ACTIVE_HIGH",
      parameter SYNC_STAGES         = 2,  //Minimum # of stages should be 2
      parameter FAN_OUT             = 1     //the output of this module, "sync_clk_rst" can be made as a bus for resets with high fan-out                 
    ) (
    input                   clk,
    input                   rst,
    output  [FAN_OUT-1:0]   sync_clk_rst
    );
    
    //Register and wire Declaration
    reg     [SYNC_STAGES-1:0]   synced_async_rst_r;
    (* keep = "true" *) reg     [FAN_OUT-1:0]       sync_clk_rst_fo_r;
    //Generate statement which will synchronise assertion of asynchronous reset as per the best practises
    generate
        if(SYNC_RST_POLARITY == "ACTIVE_HIGH")
        begin
            always@(posedge clk or posedge rst)
            begin
                if(rst)
                begin
                   synced_async_rst_r   <=  {SYNC_STAGES{1'b1}};
                   sync_clk_rst_fo_r    <=  {FAN_OUT{1'b1}};
                end
                else
                begin
                   synced_async_rst_r   <=  {synced_async_rst_r[SYNC_STAGES-2:0],1'b0};
                   sync_clk_rst_fo_r    <=  {FAN_OUT{synced_async_rst_r[SYNC_STAGES-1]}};
                end 
            end
        end
        else
        begin
            always@(posedge clk or negedge rst)
            begin
                if(!rst)
                begin
                   synced_async_rst_r   <=  {SYNC_STAGES{1'b0}};
                   sync_clk_rst_fo_r    <=  {FAN_OUT{1'b0}};
                end
                else
                begin
                   synced_async_rst_r   <=  {synced_async_rst_r[SYNC_STAGES-2:0],1'b1};
                   sync_clk_rst_fo_r    <=  {FAN_OUT{synced_async_rst_r[SYNC_STAGES-1]}};
               end 
            end
        end
    endgenerate
    
    
    //Assigning the data to the output signal
    assign sync_clk_rst =   sync_clk_rst_fo_r;
    
 endmodule
