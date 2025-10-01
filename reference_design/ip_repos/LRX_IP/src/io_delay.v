`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2018 12:15:10 PM
// Design Name: 
// Module Name: io_delay
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


module io_delay(
    input           app_clk,
    input           riu_clk,            //clock
                    riu_rst,            //reset
    input   [15:0]  ctrl_reg_16b,   //connect to 2 bytes out of 4 bytes of control register of AXI Reg map
    input   [8:0]   cntvalue_out,   //existing delay read from HSSIO IP
    input           bsc_dly_rdy,    //BITSLICE_CONTROL.DLY_RDY
                    bsc_vtc_rdy,    //BITSLICE_CONTROL.DLY_RDY
    
    output  [15:0]  status_reg_16b,    //connect to 2 bytes out of 4 bytes of status register of AXI Reg map
    output  [8:0]   cntvalue_in,    //new computed delay
    output          load,           //LOAD signal to HSSIO IP
                    ce,             //CLOCK ENABLE signal to HSSIO IP
                    inc,            //INC signal to HSSIO IP
                    rx_en_vtc       //TX_BITSLICE.EN_VTC
    );
    //STATES  
    localparam  IDLE                =	 4'd0;
    localparam  LOW_EN_VTC		    =	 4'd1;
    localparam  WAIT_10_CYCLES_i1	=	 4'd2;
    localparam  COMMAND_DECODE      =	 4'd3;
    localparam  CALC_DIFF           =    4'd4;
    localparam  VL_CALC_ADDEND      =    4'd5;
    localparam  VL_CALC_NEW_DELAY   =    4'd6;
    localparam  VL_LOAD_HIGH        =    4'd7; 
    localparam  VL_LOAD_LOW         =    4'd8; 
    localparam  VL_WAIT_5_CYCLES    =    4'd9; 
    localparam  V_INC_DEC_DELAY     =    4'd10;
    localparam  V_LOAD_NEW_DELAY    =    4'd11;
    localparam  WAIT_10_CYCLES_i2   =    4'd12;
    localparam  HIGH_EN_VTC         =    4'd13;
    
    //COMMANDS
    localparam  READ_DELAY		    =   3'd0;
    localparam  V_INC_DELAY         =   3'd1;
    localparam  V_DEC_DELAY         =   3'd2;
    localparam  VL_UPDATE_DELAY     =   3'd3;
    
    
    wire    trig_iod,
            trig_iod_re,        //start iodelay trigger
            trig_iod_re_dbapp; 
    
    reg     [2:0]   cmd_id, n_cmd_id;
    
    reg     [3:0]   state,          n_state,
                    clk_cntr,       n_clk_cntr,
                    delay_addend,   n_delay_addend;
  
    reg     [8:0]   diff,           n_diff,
                    read_delay,     n_read_delay,   //delay read from existing IP state
                    orig_delay,     n_orig_delay,
                    new_delay,      n_new_delay,    //delay to be updated
                    user_delay_i,   n_user_delay_i; //delay requested by user
    
    reg             load_sm,            n_load_sm,
                    inc_sm,             n_inc_sm,
                    ce_sm,              n_ce_sm,
                    direc,              n_direc,
                    delay_read_done,    n_delay_read_done,
                    rx_bitslice_en_vtc, n_rx_bitslice_en_vtc;
    
    
    assign  status_reg_16b  =   {delay_read_done,{6'b0},read_delay}; //1+6+9 bits = 16 bits
    assign  trig_iod        =   ctrl_reg_16b[15];
    assign  cntvalue_in     =   new_delay;
    assign  load            =   load_sm;    
    assign  ce              =   ce_sm;      
    assign  inc             =   inc_sm;     
    assign  rx_en_vtc       =   rx_bitslice_en_vtc;
    
    
    
    
    always @(posedge riu_clk or posedge riu_rst)
    begin
        if(riu_rst)
        begin
            state               <=  IDLE;
            diff                <=  0;
            load_sm             <=  0;
            inc_sm              <=  0;
            ce_sm               <=  0;
            clk_cntr            <=  4'b0;
            cmd_id              <=  3'd0;
            read_delay          <=  9'd0;
            orig_delay          <=  9'd0;
            new_delay           <=  9'd0;
            direc               <=  1'b0;
            delay_read_done     <=  1'b0;
            rx_bitslice_en_vtc  <=  1'b1;
            delay_addend        <=  4'b0;
            user_delay_i        <=  9'd0;
        end
        else
        begin
            state               <=  n_state;
            diff                <=  n_diff;
            load_sm             <=  n_load_sm;
            inc_sm              <=  n_inc_sm;
            ce_sm               <=  n_ce_sm;
            clk_cntr            <=  n_clk_cntr;
            cmd_id              <=  n_cmd_id;
            read_delay          <=  n_read_delay;
            orig_delay          <=  n_orig_delay;
            new_delay           <=  n_new_delay;
            direc               <=  n_direc;
            delay_read_done     <=  n_delay_read_done;
            rx_bitslice_en_vtc  <=  n_rx_bitslice_en_vtc;
            delay_addend        <=  n_delay_addend;
            user_delay_i        <=  n_user_delay_i;
        end
    end
    
    
    
    
    always @(*)
    begin
        n_state                 =   state;
        n_clk_cntr              =   4'b0;
        n_rx_bitslice_en_vtc    =   rx_bitslice_en_vtc;
        n_cmd_id                =   cmd_id;
        n_direc                 =   direc;
        n_inc_sm                =   inc_sm;
        n_diff                  =   diff;
        n_delay_addend          =   delay_addend;
        n_new_delay             =   new_delay;
        n_delay_read_done       =   delay_read_done;
        n_orig_delay            =   orig_delay;
        n_load_sm               =   1'b0;
        n_ce_sm                 =   1'b0;
        n_user_delay_i          =   user_delay_i;
        n_read_delay			=	read_delay;
		
        case (state)
        IDLE:
            begin
                n_clk_cntr      =    4'b0;
                n_new_delay     =   9'd0;
                n_direc         =   1'b0;
                
                if (trig_iod_re)
                begin
                    n_state         =   LOW_EN_VTC;
                    n_cmd_id        =   ctrl_reg_16b[14:12];
                    n_user_delay_i  =   ctrl_reg_16b[8:0];
                end
                else
                begin
                    n_state         =   IDLE;
                    n_cmd_id        =   READ_DELAY; 
                    n_user_delay_i  =   9'd0;
                end
            end
        
        LOW_EN_VTC:
            begin
                n_delay_read_done =    1'b0;
                if    (bsc_vtc_rdy)
                begin
                    n_rx_bitslice_en_vtc    =    1'b0;
                    n_state                 =    WAIT_10_CYCLES_i1;
                end
                else    
                begin
                    n_rx_bitslice_en_vtc    =    rx_bitslice_en_vtc;
                    n_state                 =    LOW_EN_VTC;
                end
            end
        
        WAIT_10_CYCLES_i1:
            begin    
                if(clk_cntr == 4'd10)//cnt10_1 counts 0 to 9
                begin    
                    n_clk_cntr  =    4'd0;
                    n_state     =    COMMAND_DECODE;
                end
                else
                begin    
                    n_clk_cntr  =    clk_cntr + 1'd1;
                    n_state     =    WAIT_10_CYCLES_i1;
                end
            end
        
        COMMAND_DECODE:
            begin
                n_read_delay        =   cntvalue_out;
                n_orig_delay        =   cntvalue_out;
             //case structure based on i/p command
                case (cmd_id)
                READ_DELAY:
                    n_state    =    WAIT_10_CYCLES_i2;
                V_INC_DELAY:
                    n_state    =    V_INC_DEC_DELAY;
                V_DEC_DELAY:
                    n_state    =    V_INC_DEC_DELAY;
                VL_UPDATE_DELAY:
                    n_state    =    CALC_DIFF;
                default:
                    n_state    =    WAIT_10_CYCLES_i2;
                endcase
            end
        
        
        V_INC_DEC_DELAY:
            if (cmd_id == V_INC_DELAY)
            begin
                n_inc_sm    =   1'b1;
                n_ce_sm     =   1'b1;
                n_state     = V_LOAD_NEW_DELAY;
            end
            else if (cmd_id == V_DEC_DELAY)
            begin
                n_inc_sm    =   1'b0;
                n_ce_sm     =   1'b1;
                n_state     =   V_LOAD_NEW_DELAY;
            end
            else
            begin
                n_inc_sm    =   1'b0;
                n_ce_sm     =   1'b0;
                n_state     =   WAIT_10_CYCLES_i2;
            end
    
        
        V_LOAD_NEW_DELAY:
            begin
                n_ce_sm     =   1'b0;
                n_state     =   WAIT_10_CYCLES_i2;        
            end
        
        CALC_DIFF:
            begin    
                n_state    =    VL_CALC_ADDEND;
                if(orig_delay > user_delay_i)
                begin    
                    n_diff = orig_delay - user_delay_i;
                    n_direc = 1'b0; //DECREMENT
                end
                else if(user_delay_i > orig_delay)
                begin    
                    n_diff = user_delay_i - orig_delay;
                    n_direc = 1'b1; //INCREMENT
                end
                else
                begin
                    n_diff = 0;
                    n_direc = 1'b0; //Do nothing
                end
            end
                        
        VL_CALC_ADDEND:
            begin
                n_state         =   VL_CALC_NEW_DELAY;
                if (diff <= 9'd8)
                begin
                    n_delay_addend  =   diff[3:0];
                end
                else
                begin
                    n_delay_addend   =   4'd8;
                end
            end
        
        VL_CALC_NEW_DELAY:       
            begin
                n_state         =   VL_LOAD_HIGH;
                if(direc == 1'b0)
                    n_new_delay = orig_delay - delay_addend; //CNTVALUE_IN
                    
                else if(direc == 1'b1)
                    n_new_delay = orig_delay + delay_addend;
                
                else                    
                    n_new_delay = new_delay;
            end
        
        VL_LOAD_HIGH:
            begin    
                n_load_sm   =    1'b1;
                n_state     =    VL_LOAD_LOW;
            end        
        
        VL_LOAD_LOW:
            begin
                if(diff!=9'd0)
                begin
                    n_load_sm   =    1'b0;
                    n_state     =    VL_WAIT_5_CYCLES;
                end            
                else
                begin
                    n_load_sm   =    1'b0;
                    n_state     =    WAIT_10_CYCLES_i2;
                end
            end
        
    
        
        VL_WAIT_5_CYCLES:
            begin    
                if(clk_cntr == 4'd5) //clk_cntr counts 0 to 4
                begin    
                    n_orig_delay  =   cntvalue_out;
                    n_clk_cntr  =    4'd0;
                    n_state     =    CALC_DIFF;
                end
                else
                begin    
                    n_clk_cntr  =    clk_cntr + 1'd1;
                    n_state     =    VL_WAIT_5_CYCLES;
                end
            end
        
        WAIT_10_CYCLES_i2:
            begin 
                n_delay_read_done   =    1'b1;
                n_read_delay        =   cntvalue_out;
                n_orig_delay        =   cntvalue_out;
                if(clk_cntr == 4'd10) //clk_cntr counts 0 to 9
                begin    
                    n_clk_cntr  =    4'd0;
                    n_state     =    HIGH_EN_VTC;
                end
                else
                begin    
                    n_clk_cntr  =    clk_cntr + 1'd1;
                    n_state     =    WAIT_10_CYCLES_i2;
                end
            end
            
        HIGH_EN_VTC:
            begin
                n_rx_bitslice_en_vtc  = 1'b1;
                n_state             =    IDLE;
            end
            
        default:        
            begin
                n_state                 =   IDLE;
                n_clk_cntr              =   4'b0;
                n_rx_bitslice_en_vtc    =   rx_bitslice_en_vtc;
                n_cmd_id                =   cmd_id;
                n_direc                 =   direc;
                n_inc_sm                =   inc_sm;
                n_diff                  =   diff;
                n_delay_addend          =   delay_addend;
                n_new_delay             =   new_delay;
                n_read_delay            =   read_delay;
                n_delay_read_done       =   delay_read_done;
                n_orig_delay            =   orig_delay;
                n_load_sm               =   1'b0;
                n_ce_sm                 =   1'b0;
                n_user_delay_i          =   user_delay_i;
            end
    endcase
    end
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
        sync_stage_i0       (
        .src_data   (trig_iod_re),
        .dest_clk   (app_clk),              //app clk
        .dest_data  (trig_iod_re_dbapp)
        ); 
        
    edge_detection edge_det_e1(
        .clk            (riu_clk),
        .rst            (riu_rst),
        .signal         (trig_iod),
        .rising_edge    (trig_iod_re),
        .falling_edge   ()
        );
        
endmodule
