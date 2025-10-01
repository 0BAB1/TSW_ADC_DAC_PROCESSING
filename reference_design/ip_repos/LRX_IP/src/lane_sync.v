`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Soliton technologies
// Engineer: 
// 
// Create Date: 02/23/2017 04:46:15 PM
// Design Name: LRX
// Module Name: lane sync
// Project Name: WBLVDS
// Target Devices: TSW14DL3200
// Tool Versions: 2017.1
// Description: Lane will by synchronized w.r.t strobe to solve lane synchronation issue
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////
//----------------------------parameter and local param----------------------------


module lane_sync(
    clk,
    rst_in,
    start_lane_align_i,     //start signal for lane alignment
    
	//input data before bitslip
    raw_data_i,             // [DESER_FACTOR-1:0] input data 
    raw_strobe_i,           //ref data for synchronous
    
	//output data after alignment
    lane_sync_data_o,       // [DESER_FACTOR-1:0] synchronized output
    lane_sync_strobe_o,
    
	//fifo
    data_valid_o   // valid data handshake - 0 clk latency
    );

    parameter STROBE_PAT1 		= 8'hff;
    parameter STROBE_PAT2 		= 8'h00;
    parameter DESER_FACTOR   	= 8;

    localparam bit_per_frame 	= 16;
    
    input   clk;
    input   rst_in;
    
    input   [DESER_FACTOR-1:0]	raw_strobe_i;
    input   [DESER_FACTOR-1:0]	raw_data_i;
    
    input   start_lane_align_i;
    
    output  [DESER_FACTOR-1:0]	lane_sync_data_o;
    output  [DESER_FACTOR-1:0]	lane_sync_strobe_o;
    
    output  data_valid_o;

//------------------------signal declaration-------------------------------
    wire  	data_valid_o,
			start_lane_align_i;
    wire	[DESER_FACTOR-1:0]	lane_sync_data_o;
    wire	[DESER_FACTOR-1:0]	lane_sync_strobe_o;
    
    reg		[6:0]	case_left;
    reg		[6:0]	case_right;
    reg		case_noshift;
    
    reg		[DESER_FACTOR-1:0]	datain_r;
    reg		[DESER_FACTOR-1:0]	datain_rr;
    reg		[DESER_FACTOR-1:0]	datain_rrr;
    
    wire	[bit_per_frame*2-1:0]	concat_strobe;
    wire	[bit_per_frame*2-1:0]	concat_data;
    
    wire 	start_align;
    
    wire    strobe_check;
    //no. of bits shifted
    wire 	no_shift_position;
    wire 	[6:0]	left_shift_position;
    wire 	[6:0]	right_shift_position;
    
    
    //shift direction
    wire	no_shift_valid;
    wire	left_shift_valid;
    wire	right_shift_valid;
    
    
    reg		[DESER_FACTOR-1:0]	right_aligned_data;
    reg		[DESER_FACTOR-1:0]	left_aligned_data;
    reg		[DESER_FACTOR-1:0]	data_without_shift;
			
    reg		[DESER_FACTOR-1:0]	data_out;
    reg		[DESER_FACTOR-1:0]	strobe_out;
		
    reg		[5:0]	data_valid;
		
    reg		[2:0]	load_data_en; //0th bit - no shift 1st bit-left shift 2nd bit- right shift
		
    reg		[2:0]	curr_state;
    reg		[2:0]	nxt_state;
		
    reg		n_load_shift_case_en;
    reg		n_valid_data;
			
    reg		valid_data;
    reg		load_shift_case_en;
	//----------------registered signals declaration-------------------------

    reg 	no_shift_position_r;
    reg 	[7:0]	left_shift_position_r;
    reg 	[7:0]	right_shift_position_r;
    
    reg 	[DESER_FACTOR-1:0]	data_out_r;
		
    reg 	[DESER_FACTOR-1:0]	strobein_r;
    reg 	[DESER_FACTOR-1:0]	strobein_rr;
    reg 	[DESER_FACTOR-1:0]	strobein_rrr;
			
    reg 	[DESER_FACTOR-1:0]	strobe_out_r;
		
    reg 	no_shift_valid_r;
    reg 	left_shift_valid_r;
    reg 	right_shift_valid_r;
		
    reg 	case_noshift_r;
    reg 	[6:0]case_left_r   ;
    reg 	[6:0]case_right_r  ;
		
    reg 	[bit_per_frame*2-1:0]concat_strobe_r;
    reg 	[bit_per_frame*2-1:0]concat_data_r;
    reg 	[bit_per_frame*2-1:0]concat_strobe_rr;
		
    reg 	no_shift_position_rr;
    reg 	[6:0]left_shift_position_rr;
    reg 	[6:0]right_shift_position_rr;

    // ----------------regestering data and strobe--------------------
    always @(posedge clk or posedge rst_in)
	begin
		if(rst_in)
		begin
			load_data_en		<=	3'd0;					
			data_valid			<= 6'd0;	
			
			data_without_shift	<= 8'd0;	
		end
		else
		begin
			data_valid			<= {data_valid[4:0],valid_data};
		
			load_data_en[0]		<=	case_noshift_r;	
			load_data_en[1]     <= | case_left_r;
			load_data_en[2]     <= | case_right_r;
		
			data_without_shift	<=	concat_data_r[15-:8];  
		end
	end

    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in) 
        begin
            no_shift_valid_r		<= 'd0;
            left_shift_valid_r		<= 'd0;
            right_shift_valid_r		<= 'd0;
                                       
            datain_r        	 	<= 'd0;
            datain_rr      	 		<= 'd0;
            datain_rrr		 	 	<= 'd0;
                                       
            strobein_r        		<= 'd0;
            strobein_rr      	 	<= 'd0;
            strobein_rrr		 	<= 'd0;
                                       
            data_out_r				<= 'd0;
            strobe_out_r         	<= 'd0;
                                      
            case_noshift_r			<= 'd0;
            case_left_r          	<= 'd0;
            case_right_r         	<= 'd0;
                                    
            concat_strobe_r			<= 'd0;
            concat_strobe_rr		<= 'd0;
                                     
            concat_data_r			<= 'd0;
                                     
            left_shift_position_r	<= 'd0;
            right_shift_position_r	<= 'd0;
            no_shift_position_r		<= 'd0;
                                       
            left_shift_position_rr	<= 'd0;
            right_shift_position_rr	<= 'd0;
            no_shift_position_rr	<= 'd0;
        end
        else 
        begin
            no_shift_valid_r		<= no_shift_valid;
            left_shift_valid_r		<= left_shift_valid;
            right_shift_valid_r		<= right_shift_valid;
            
            datain_r        	 	<= #10 raw_data_i;
            datain_rr      	 		<= datain_r;
            datain_rrr		 	 	<= datain_rr;
    
            strobein_r        		<= #10 raw_strobe_i;
            strobein_rr      	 	<=  strobein_r;
            strobein_rrr		 	<=  strobein_rr;
            
            data_out_r				<= data_out;
            strobe_out_r         	<= strobe_out;
            
            case_noshift_r			<= case_noshift;
            case_left_r          	<= case_left;
            case_right_r         	<= case_right;
            
            concat_strobe_r			<= concat_strobe;
            concat_strobe_rr		<= concat_strobe_r;
            
            concat_data_r			<= concat_data;
    
            left_shift_position_r	<=	left_shift_position;
            right_shift_position_r	<=	right_shift_position;
            no_shift_position_r		<=  no_shift_position;
                            
            left_shift_position_rr	<= left_shift_position_r;
            right_shift_position_rr	<= right_shift_position_r;
            no_shift_position_rr	<= no_shift_position_r	;
	       end
    end
	
    rise_fal_edge rise_name(
        .clk_in      	(clk)  ,    //input clk
        .rst_in       	(rst_in) ,    //active high rst
        .signal_in    	(start_lane_align_i),    //1b signal to which rise and falling edge to be detected
        .rise_out    	(start_align),     // output pulse of rising edge
        .fall_out		()        //output pulse of falling edge
    );
    /*
    state 1 - start calibration and go to pattern check
    state 5 - pattern check and wait for valid shift detection
    state 6 - disable pattern check and load valid shift 
    state 7 - asssert done calibration and go to state 1
    */	

    //state declaration
    localparam IDLE  	        = 3'd0,
               WAIT0            = 3'd1,
               WAIT1            = 3'd2,
               WAIT2            = 3'd3,
               SHIFT_DETECT 	= 3'd4,
               CLR_LOAD_EN      = 3'd5,
               SET_VALID		= 3'd6;


    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in)
        begin
            curr_state          <= 3'd0;
            load_shift_case_en  <= 1'd0;
            valid_data			<= 1'd0;
        end
        else
        begin
            curr_state          <= nxt_state;
            load_shift_case_en  <= n_load_shift_case_en;
            valid_data			<= n_valid_data;
        end
    end

    // state definition and next state detection
    always @(*)
    begin
        //default values
        nxt_state       		= curr_state; 
        n_load_shift_case_en    = load_shift_case_en;
        n_valid_data			= valid_data;
         
        case(curr_state)
			IDLE :
			begin
				if(start_align)
				begin
					nxt_state       	   = WAIT0;
					n_valid_data    	   = 1'b0; 
				end
				else
					nxt_state 			   = IDLE;
			end
			WAIT0:
				nxt_state 				   = WAIT1; //rr,r,live
			WAIT1:
				nxt_state 				   = WAIT2;//rrr,rr,r,live
			WAIT2:
				nxt_state 				   = SHIFT_DETECT; //reg shift position ,valid data in -> concat_r and shift_position_r are sync
			SHIFT_DETECT :
			begin
				if(|{no_shift_valid,left_shift_valid,right_shift_valid}) //shift_valild and concat_r are sync
				begin
					nxt_state 			   = CLR_LOAD_EN; //valid data in -> concat_rr
					n_load_shift_case_en   = 1'b1;  
				end
			else
				nxt_state 				   = SHIFT_DETECT;
			end           
			CLR_LOAD_EN :
			begin
				n_load_shift_case_en   	   = 1'd0;
				nxt_state 			   	   = SET_VALID; 
			end
			SET_VALID :
			begin
				n_valid_data			   = 1'd1;
				nxt_state				   = IDLE;
			end
        endcase
    end

    //data_valid and case_xxxx are sync
    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in)
        begin
            case_noshift  	<= 1'd0;
            case_left   	<= 7'd0;
            case_right  	<= 7'd0; 
        end
        else if(load_shift_case_en)
        begin
			case_noshift	<= no_shift_position_rr;   //concat_rr and shift_position_rr are sync
            case_left   	<= left_shift_position_rr;
            case_right  	<= right_shift_position_rr;
        end
        else
        begin
			case_noshift	<= case_noshift;
            case_left   	<= case_left;
            case_right  	<= case_right; 			 
        end
    end	

//actual comparison done at top is with concat_data_rrr(takes four clk cycles to reach the case structure) but due to net complexity , 
//that sample is missed and start sending the valid data from next sample
//-------------------left alignment-----------------------	
	always@(posedge clk or posedge rst_in)
	begin			//00,ff,00 -> 1st ff will be missed,bze if it is left shifted, then junk data may occured
        if(rst_in)
                left_aligned_data   <= 8'd0;	
		else begin                        //rr,r,l                            rrr,rr,r
                case(case_left) //use concat_rrr
                7'b0000001://LEFT_BITSHIFT_BY1
                    left_aligned_data   <=   concat_data_r[14-:8];							
                7'b0000010: //LEFT_BITSHIFT_BY2                                                            
                    left_aligned_data   <=   concat_data_r[13-:8];                            
                7'b0000100: //LEFT_BITSHIFT_BY3                                                             
                    left_aligned_data   <=    concat_data_r[12-:8];                         
                7'b0001000: //LEFT_BITSHIFT_BY4                                                            
                    left_aligned_data   <=    concat_data_r[11-:8];                          
                7'b0010000: //LEFT_BITSHIFT_BY5
                    left_aligned_data   <=    concat_data_r[10-:8]; 
                7'b0100000: //LEFT_BITSHIFT_BY6
                    left_aligned_data   <=    concat_data_r[09-:8]; 
                7'b1000000: //LEFT_BITSHIFT_BY7
                    left_aligned_data   <=    concat_data_r[08-:8]; 
                default    :
                    left_aligned_data   <=    8'd0;
                endcase
        end
	end
    //----------------------right alignment-------------------------
	always@(posedge clk or posedge rst_in)
	begin	
        if(rst_in)
                right_aligned_data   <=     8'd0;
        else 
        begin
            case(case_right)
            7'b0000001://RIGHT_BITSHIFT_BY1
                right_aligned_data  <=   concat_data_r[16-:8];								
            7'b0000010://RIGHT_BITSHIFT_BY2                                                             
                right_aligned_data  <=   concat_data_r[17-:8];                             
            7'b0000100: //RIGHT_BITSHIFT_BY3                                                           
                right_aligned_data  <=   concat_data_r[18-:8];                           
            7'b0001000: //RIGHT_BITSHIFT_BY4                                                            
                right_aligned_data  <=   concat_data_r[19-:8];                           
            7'b0010000: //RIGHT_BITSHIFT_BY5
                right_aligned_data  <=   concat_data_r[20-:8];
            7'b0100000://RIGHT_BITSHIFT_BY6
                right_aligned_data  <=   concat_data_r[21-:8];
            7'b1000000://RIGHT_BITSHIFT_BY7
                right_aligned_data  <=   concat_data_r[22-:8];
            default    :
                right_aligned_data  <=    8'd0;
            endcase
        end  
	end
//----------------------------loading valid data---------------------------------------

    always @(posedge clk or posedge rst_in)
	begin
		if(rst_in)
        begin
            data_out	<= 8'd0;
            strobe_out  <= 8'd0;		
        end
		else if(load_data_en[0])
        begin
            data_out	<=	data_without_shift;
            strobe_out  <= concat_strobe_rr[15-:8];
        end
		else if(load_data_en[1])
        begin
            data_out	<=	left_aligned_data;
            strobe_out  <= concat_strobe_rr[15-:8];
        end
		else if(load_data_en[2])
        begin
            data_out	<=	right_aligned_data;
            strobe_out  <= concat_strobe_rr[15-:8];
        end
		else
        begin
            data_out	<=	8'd0;
            strobe_out  <= 8'd0;
        end
	end	

//-----------------------assign statement-------------------------------
    assign concat_strobe  			= {raw_strobe_i,strobein_r,strobein_rr,strobein_rrr};
    assign concat_data				= {raw_data_i,datain_r,datain_rr,datain_rrr};
    assign strobe_check				= (concat_strobe[23-:16]== {STROBE_PAT2,STROBE_PAT1});
    
    assign no_shift_position		= (concat_data[23-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);  //without shift
    
    assign left_shift_position[0] 	= (concat_data[22-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);	  //no. of bits shifted detection
    assign left_shift_position[1]	= (concat_data[21-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);	  //no. of bits shifted detection	
    assign left_shift_position[2] 	= (concat_data[20-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign left_shift_position[3]	= (concat_data[19-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign left_shift_position[4] 	= (concat_data[18-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign left_shift_position[5]	= (concat_data[17-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign left_shift_position[6] 	= (concat_data[16-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
                               
    
    assign right_shift_position[0]	= (concat_data[24-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);	  //no. of bits shifted detection
    assign right_shift_position[1]	= (concat_data[25-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);	  //no. of bits shifted detection	
    assign right_shift_position[2] 	= (concat_data[26-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign right_shift_position[3]	= (concat_data[27-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign right_shift_position[4] 	= (concat_data[28-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign right_shift_position[5]	= (concat_data[29-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection    
    assign right_shift_position[6] 	= (concat_data[30-:16] == {STROBE_PAT2,STROBE_PAT1}) && (strobe_check);    //no. of bits shifted detection 
    
    assign no_shift_valid			= no_shift_position_r;	
    assign left_shift_valid			= | left_shift_position_r;
    assign right_shift_valid		= | right_shift_position_r;
    
    //output declaration-------------------------------
    
    assign	lane_sync_data_o		= data_out_r;
    assign	lane_sync_strobe_o		= strobe_out_r;
    assign	data_valid_o			= data_valid[3];

endmodule