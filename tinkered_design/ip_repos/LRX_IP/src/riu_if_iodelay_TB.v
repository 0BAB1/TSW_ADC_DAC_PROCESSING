`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2018 12:35:10 PM
// Design Name: 
// Module Name: riu_if_iodelay_TB
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


module riu_if_iodelay_TB();
    reg   clk;                    
    reg   rst;                    
    reg   valid_i;                
    reg   [5:0] addr_i;                
    reg   nib_i;        
    reg   trig_re;        //trigge
    reg   [1:0] bg_i;
    reg   [15:0]  riu_rd_data_bg0;
    reg   [15:0]  riu_rd_data_bg1;
    reg   [15:0]  riu_rd_data_bg2;
    reg   [15:0]  riu_rd_data_bg3;
    
    wire  [5:0]   riu_addr;       
    wire  [1:0]   riu_nib_sel;    
    wire  [15:0]  rd_data_o;      
    wire          rd_done_o;       

    initial
    begin
        clk     =   1'b0;
        rst     =   1'b1;
        valid_i =   1'b0;
        addr_i  =   6'd0;
        nib_i   =   1'b0;
        bg_i    =   2'd0;
        trig_re =   1'b0;
        riu_rd_data_bg0 =   16'd0;
        riu_rd_data_bg1 =   16'd1;
        riu_rd_data_bg2 =   16'd2;
        riu_rd_data_bg3 =   16'd3;
        
        #10 rst = 1'b0;
        #15 trig_re =   1'b1;
            addr_i  =   6'h10;
            nib_i   =   1'b1;
            bg_i    =   2'd3;
        #10 trig_re =   1'b0;
        #15 valid_i =   1'b1;
        
        #50 trig_re =   1'b1;
            addr_i  =   6'h55;
            nib_i   =   1'b0;
            bg_i    =   2'd1;
        #10 trig_re =   1'b0;
        #15 valid_i =   1'b1;
    end

    always
    begin
        #5 clk =   !clk;
    end
    
    riu_if_iodelay  UUT(
        .clk             (clk    ),   
        .rst             (rst    ),               
        .valid_i         (valid_i),                    //valid_i = & bg_valid[3:0]
        .addr_i          (addr_i ),                     //address specified
        .nib_i           (nib_i  ),                      //upper/lower nibble specified
        .trig_re         (trig_re),        //trigger to denote new reg write has been done oncommand
        .bg_i            (bg_i   ),  
        .riu_rd_data_bg0 (riu_rd_data_bg0),    //data from all bytegroups
        .riu_rd_data_bg1 (riu_rd_data_bg1),
        .riu_rd_data_bg2 (riu_rd_data_bg2),
        .riu_rd_data_bg3 (riu_rd_data_bg3),
        .riu_addr        (riu_addr   ),           //addr to be connected to riu if
        .riu_nib_sel     (riu_nib_sel),        //nibble select to be connected to riu if
        .rd_data_o       (rd_data_o  ),          //data read from riu
        .rd_done_o       (rd_done_o  )    //read from specified riu reg done 
        );
    
    
endmodule
