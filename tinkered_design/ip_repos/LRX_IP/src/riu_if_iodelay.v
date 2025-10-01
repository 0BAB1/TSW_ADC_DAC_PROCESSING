`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2018 11:26:35 AM
// Design Name: 
// Module Name: riu_if_iodelay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      This sub-module is used for RIU Interface for IO Delay. 
//      It parses the address and reads the data corresponding to that address from all BGs. 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module riu_if_iodelay(
    input   clk,
    input   rst,
    input   valid_i,                    //valid_i = & bg_valid[3:0]
    input   nib_i,                      //upper/lower nibble specified
    input   trig_re,        //trigger to denote new reg write has been done oncommand
    input   [1:0]   bg_i,
    input   [5:0]   addr_i,                     //address specified
    input   [15:0]  riu_rd_data_bg0,    //data from all bytegroups
    input   [15:0]  riu_rd_data_bg1,
    input   [15:0]  riu_rd_data_bg2,
    input   [15:0]  riu_rd_data_bg3,
    output  [5:0]   riu_addr,           //addr to be connected to riu if
    output  [1:0]   riu_nib_sel,        //nibble select to be connected to riu if
    output  [15:0]  rd_data_o,          //data read from riu
    output          rd_done_o,           //read from specified riu reg done 
    output          rst_ctrl_reg_riu
    );
    
    //Declarations for state machine   
     reg     [15:0]  rd_data,
                     n_rd_data;
        
     reg     [5:0]   addr,
                     n_addr;
        
     reg     [2:0]   state,
                     n_state;
        
     reg     [1:0]   nib_sel,
                     n_nib_sel;
        
     reg             n_rd_done,
                     rd_done,
                     rst_ctrl_reg,
                     n_rst_ctrl_reg;
                    
    //Output assignments     
    assign  rd_data_o   =   rd_data;
    assign  rd_done_o   =   rd_done;
    assign  riu_addr    =   addr;
    assign  riu_nib_sel =   nib_sel;

    localparam   IDLE               =   3'd0; 
    localparam   WAIT_FOR_VALID     =   3'd1; 
    localparam   NIBBLE_SELECT      =   3'd2; 
    localparam   WAIT_1_CYCLE       =   3'd3; 
    localparam   READ_REG_DATA      =   3'd4; 
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            state           <=  IDLE;
            addr            <=  6'b0;
            nib_sel         <=  2'b0;
            rd_done         <=  1'b0;
            rd_data         <=  16'b0;
            rst_ctrl_reg    <=  1'b0;
        end
        else
        begin
            state           <=  n_state;
            addr            <=  n_addr;
            nib_sel         <=  n_nib_sel;
            rd_done         <=  n_rd_done;
            rd_data         <=  n_rd_data;
            rst_ctrl_reg    <=  n_rst_ctrl_reg;
        end
    end
    
    always @ (*)
    begin
        n_state         =   state;
        n_nib_sel       =   2'b0;
        n_rd_done       =   rd_done;
        n_rd_data       =   rd_data;
        n_addr          =   addr;
        n_rst_ctrl_reg  =    rst_ctrl_reg;
        
        case (state)
            
            IDLE:
            begin
                n_addr    =    addr_i;
                if (trig_re) 
                    n_state    =    WAIT_FOR_VALID;
            end
            
            WAIT_FOR_VALID:
            begin
                if (valid_i)    
                begin
                    n_state    =    NIBBLE_SELECT;
                    n_rd_done  =  1'b0;
                end
            end
            
            NIBBLE_SELECT:  //select the necessary nibble
            begin
                n_state    =    WAIT_1_CYCLE;
                if(nib_i == 1'b0)
                    n_nib_sel    =    2'b01; //wire nib_sel[1:0]; nib_sel to be taken care by SW
                else
                    n_nib_sel    =    2'b10;
            end
            
            WAIT_1_CYCLE:
            begin
                n_state    =    READ_REG_DATA;
                n_rst_ctrl_reg  =   1'b1;
            end
            
            READ_REG_DATA:  //Read the data based on Bytegroup
            begin
                n_state         =    IDLE;
                n_rd_done       =  1'b1;
                n_rst_ctrl_reg  =   1'b0;
                case (bg_i)
                    2'd0:    n_rd_data    =    riu_rd_data_bg0; //wire riu_rd_data[15:0][3:0]
                    2'd1:    n_rd_data    =    riu_rd_data_bg1; //wire riu_rd_data[15:0][3:0]
                    2'd2:    n_rd_data    =    riu_rd_data_bg2; //wire riu_rd_data[15:0][3:0]
                    2'd3:    n_rd_data    =    riu_rd_data_bg3; //wire riu_rd_data[15:0][3:0]
                endcase
            end
        endcase
    end
    
endmodule