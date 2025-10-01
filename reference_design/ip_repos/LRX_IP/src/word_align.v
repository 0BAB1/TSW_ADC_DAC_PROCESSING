`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Soliton technologies
// Engineer: Vamsi Krishna Guggilam
// 
// Create Date: 18.12.2017 14:54:39
// Design Name: LRX
// Module Name: word_align
// Project Name: WBLVDS
// Target Devices: TSW14Dl3200
// Tool Versions: 2017.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//------------------------------------Logic for the Bank alignment---------------------------------------------//
// Assumption - Lane alignment will not go low once it is high
// Assumption2 - All the lanes in a bank are completely aligned
// Need to optimize the logic further for any kind of the ADC   
//-------------------------------------------------------------------------------------------------------------//


/**************
Output data from the module is one clock cycle ahead of the wr_en
The wr_en will be registered in the top module
***************/

module word_align    #(  
        parameter   STROBE_PAT1 =   8'h00,  //h80 00
        parameter   STROBE_PAT2 =   8'h80  //h80 00
    )(
    input               deser_clk,
    input               reset,
    input   [7:0]       lane_sync_data,
    input   [7:0]       lane_sync_strobe,
    input               lane_valid,
    output  [7:0]       word_sync_data,
    output  [7:0]       word_sync_strobe,
    output              word_valid
    );
    
    localparam  STROBE_LENGTH   =   8'd2;
    localparam  CNTR_WIDTH      =   8'd2;
    
    //The lenght of the following register has to be handled if there is any update in the module
    reg     [(STROBE_LENGTH*8)-1:0]     shift_reg_data;
    reg     [CNTR_WIDTH-1:0]            cntr;
    reg     strobe_cmp,
            word_valid_r;
    wire    lane_valid_r;  
      
 
    //shift register
    always@(posedge deser_clk or posedge reset)begin
		if(reset)
			shift_reg_data	<= 16'd0;
		else
			shift_reg_data   <=  {shift_reg_data[7:0],lane_sync_data};
    end 
    
    //Checks if the shift register is equal to strobe pattern
    always@(posedge deser_clk or posedge reset)begin
		if(reset)
			strobe_cmp	<= 1'd0;
		else
			strobe_cmp      <=  (shift_reg_data == {STROBE_PAT1,STROBE_PAT2});
    end     
    
    // counter logic
    always@(posedge deser_clk or posedge reset)
    begin
        if(reset)
            cntr        <=  {CNTR_WIDTH{1'd0}};
        else if ((cntr == STROBE_LENGTH-1'd1) && lane_valid_r)
            cntr        <=  {CNTR_WIDTH{1'd0}};
        else if (lane_valid_r)
            cntr        <=  cntr + 1'd1;
        else
            cntr        <=  cntr;
    end

    //word align logic
    always@(posedge deser_clk or posedge reset)
    begin
        if(reset)    
            word_valid_r    <=  1'd0;
        else if(!lane_valid_r)
            word_valid_r    <=  1'd0;
        else if((lane_valid_r) & (cntr == STROBE_LENGTH-1'd1))
            word_valid_r    <=  !strobe_cmp;
        else
            word_valid_r    <=  word_valid_r;
    end        
    
    assign  word_valid      =   word_valid_r; 

    //Registering the lane_valid wrt to clock
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i1   (
        .src_data           (lane_valid), 
        .dest_clk           (deser_clk),
        .dest_data          (lane_valid_r)
    );
    
    //registering input data and the strobe to align with the word_valid signal
    sync_stage #(.C_SYNC_STAGE(5), .C_DW(8), .pTCQ(100)) 
    sync_stage_i2   (
        .src_data           (lane_sync_data), 
        .dest_clk           (deser_clk),
        .dest_data          (word_sync_data)
    );
        
    sync_stage #(.C_SYNC_STAGE(5), .C_DW(8), .pTCQ(100)) 
    sync_stage_i3   (
        .src_data           (lane_sync_strobe), 
        .dest_clk           (deser_clk),
        .dest_data          (word_sync_strobe)
    );
    
endmodule
