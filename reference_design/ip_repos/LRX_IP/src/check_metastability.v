`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Soliton technologies
// Engineer: 
// 
// Create Date: 12/11/2017 02:09:19 PM
// Design Name: LRX
// Module Name: check_metastability
// Project Name: WBLVDS
// Target Devices: TSW14DL3200
// Tool Versions: 2017.1 
// Description: This module will check whether data integrity issue occured after update of new IOdelay value 
// Dependencies: sync_stage
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module check_metastability(
    input           clk,            //app_clk
    input           rst,            //rst_appclk
    input           rx_en_vtc_i,    // in riu_clk, to be registered with app_clk
    input   [7:0]   data_i,         // reg in app_clk to match with rx_en_vtc
    output          error_sb  
    );
    
    wire    [7:0]   data_r,
                    data;
    
    wire            vtc_re,
                    vtc_re_r,
                    vtc_re_rr,
                    vtc_re_rrrr,
                    vtc_fe,
                    rx_en_vtc;
    
    wire    [15:0]  data_16b;
   
    reg     [15:0]  cmp_pattern;
    reg             cmp_err,
                    cmp_valid,
                    cmp,
                    check_ms;

    //edge detection	
    rise_fal_edge edge_det_e1(
        .clk_in          (clk)  ,    //input clk
        .rst_in          (rst) ,    //active high rst
        .signal_in       (rx_en_vtc),    //1b signal to which rise and falling edge to be detected
        .rise_out        (vtc_re),     // output pulse of rising edge
        .fall_out        (vtc_fe)        //output pulse of falling edge
    );  	
	//Note: When initiating an IO Delay update cycle, rx_en_vtc signal will go low.
	//		On completing teh IO Delay updation, rx_en_vtc will be made high. 
	//		So, at every rising edge of the rx_en_vtc, we need to check the data integrity.
	
	//Register the comparison pattern on rising edge of delayed EN_VTC	
    always  @(posedge clk or posedge rst)
    begin
        if(rst)
            cmp_pattern <=  16'b0;
        else if (vtc_re_r)
            cmp_pattern <=  data_16b;
        else
            cmp_pattern <=  cmp_pattern;
    end
    
	//To determine if comparison valid ; valid only after rising egde of delayed rx_en_vtc
    always  @(posedge clk or posedge rst)
    begin
        if(rst)
            cmp_valid   <=  1'b0;
        else if (vtc_re_r)
            cmp_valid   <=  1'b0;
        else
            cmp_valid   <=  !cmp_valid;
    end
    
	//Compares if the live data is same as the comparison pattern; Also checks if comparison pattern is all 0's
    always  @(posedge clk or posedge rst)
    begin
        if(rst)
            cmp <=  1'b0;
        else if (cmp_valid)
            cmp <=  ((cmp_pattern == data_16b) && (cmp_pattern != 16'd0));
        else
            cmp <=  cmp;
    end
    
	//Metastability is checked till a falling edge on rx_en_vtc is seen
    always  @(posedge clk or posedge rst)
    begin
        if(rst)
            check_ms    <=  1'b0;
        else if (vtc_fe)
            check_ms    <=  1'b0;
        else if (vtc_re_rrrr)
            check_ms    <=  1'b1;
        else
            check_ms    <=  check_ms;
    end 
    
	//Check if there is an error in data at the written value of delay
    always  @(posedge clk or posedge rst)
    begin
        if(rst)
            cmp_err    <=  1'b0;
        else if (vtc_fe)
            cmp_err    <=  1'b0;
        else if ((check_ms)&&(!cmp))
            cmp_err    <=  1'b1;
        else
            cmp_err    <=  cmp_err;
    end

    assign  data_16b    =   {data_r,data};
    assign  error_sb    =   cmp_err;
	
	//registering
    sync_stage #(.C_SYNC_STAGE(1), .C_DW(8), .pTCQ(100)) 
        sync_stage_i0       (
            .src_data   (data), 
            .dest_clk   (clk), 
            .dest_data  (data_r)
	);
            
    sync_stage #(.C_SYNC_STAGE(1), .C_DW(1), .pTCQ(100)) 
        sync_stage_i1       (
            .src_data   (vtc_re), 
            .dest_clk   (clk), 
            .dest_data  (vtc_re_r)
	);
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
        sync_stage_i2       (
            .src_data   (vtc_re), 
            .dest_clk   (clk), 
            .dest_data  (vtc_re_rr)
	);

    sync_stage #(.C_SYNC_STAGE(4), .C_DW(1), .pTCQ(100)) 
        sync_stage_i3       (
            .src_data   (vtc_re), 
            .dest_clk   (clk), 
            .dest_data  (vtc_re_rrrr)
    );

    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
        sync_stage_i4       (
            .src_data   (rx_en_vtc_i), 
            .dest_clk   (clk), 
            .dest_data  (rx_en_vtc)
    );

    sync_stage #(.C_SYNC_STAGE(2), .C_DW(8), .pTCQ(100)) 
        sync_stage_i5       (
            .src_data   (data_i), 
            .dest_clk   (clk), 
            .dest_data  (data)
    );



endmodule
