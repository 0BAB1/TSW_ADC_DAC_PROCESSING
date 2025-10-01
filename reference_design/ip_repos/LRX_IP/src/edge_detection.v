`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2017 10:47:36 AM
// Design Name: 
// Module Name: edge_detection
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


module edge_detection(
    input clk,
    input rst,
    input signal,
    output rising_edge,
    output falling_edge
    );
    
    reg signal_r, signal_rr;
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            signal_r    <=  1'b0;
            signal_rr   <=  1'b0;
        end
        else
        begin
            signal_r    <= signal;
            signal_rr    <= signal_r;
        end
    end
    
    assign rising_edge  =   (~signal_rr) && (signal_r);
    assign falling_edge  =   (signal_rr) && (~signal_r);
    
endmodule
