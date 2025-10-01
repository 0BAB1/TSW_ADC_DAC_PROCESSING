`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Soliton technologies
// Engineer: 
// 
// Create Date: 02/23/2017 04:46:15 PM
// Design Name: LRX
// Module Name: bitslip
// Project Name: WBLVDS
// Target Devices: TSW14DL3200
// Tool Versions: 2017.1
// Description: No. of bits shifted from output of HSSIO IP lanes will be synchronized 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//----------------------------parameter and local param----------------------------

/*****************Note******************************/
//Valid will go high only after the one correct sample
/*****************Note******************************/


module bitslip(
    clk					,
    rst_in				,
    bitslip_start		,  //start signal for bitslipping
    strobe_i			, //ref data for synchronous
    //input data before bitslip
    raw_data0_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data1_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data2_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data3_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data4_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data5_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data6_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data7_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data8_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data9_i			, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data10_i		, // bitslipped [DESER_FACTOR-1:0] input 
    raw_data11_i		, // bitslipped [DESER_FACTOR-1:0] input 
    //output data after bitslip
    word_sync_data0_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data1_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data2_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data3_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data4_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data5_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data6_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data7_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data8_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data9_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data10_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_data11_o	,// [DESER_FACTOR-1:0] synchronized output
    word_sync_strobe_o  ,
    
    //fifo
    word_sync_valid_o   // valid data handshake - 0 clk latency
    );

    parameter STROBE_PAT1 	= 8'h00;
    parameter STROBE_PAT2 	= 8'h80;
    parameter DESER_FACTOR  = 8;
    
    localparam      bit_per_frame       = 16;
    localparam      STROBE_PATTERN      = {STROBE_PAT2,STROBE_PAT1};
    localparam      pTCQ                = 20;
    
    input clk;
    input rst_in;
    
    input [DESER_FACTOR-1:0]strobe_i;
    
    input [DESER_FACTOR-1:0]raw_data0_i;
    input [DESER_FACTOR-1:0]raw_data1_i;
    input [DESER_FACTOR-1:0]raw_data2_i;
    input [DESER_FACTOR-1:0]raw_data3_i;
    input [DESER_FACTOR-1:0]raw_data4_i;
    input [DESER_FACTOR-1:0]raw_data5_i;
    input [DESER_FACTOR-1:0]raw_data6_i;
    input [DESER_FACTOR-1:0]raw_data7_i;
    input [DESER_FACTOR-1:0]raw_data8_i;
    input [DESER_FACTOR-1:0]raw_data9_i;
    input [DESER_FACTOR-1:0]raw_data10_i;
    input [DESER_FACTOR-1:0]raw_data11_i;
    
    output [DESER_FACTOR-1:0]word_sync_data0_o;
    output [DESER_FACTOR-1:0]word_sync_data1_o;
    output [DESER_FACTOR-1:0]word_sync_data2_o;
    output [DESER_FACTOR-1:0]word_sync_data3_o;
    output [DESER_FACTOR-1:0]word_sync_data4_o;
    output [DESER_FACTOR-1:0]word_sync_data5_o;
    output [DESER_FACTOR-1:0]word_sync_data6_o;
    output [DESER_FACTOR-1:0]word_sync_data7_o;
    output [DESER_FACTOR-1:0]word_sync_data8_o;
    output [DESER_FACTOR-1:0]word_sync_data9_o;
    output [DESER_FACTOR-1:0]word_sync_data10_o;
    output [DESER_FACTOR-1:0]word_sync_data11_o;
    
    output [DESER_FACTOR-1:0]word_sync_strobe_o;
    
    input bitslip_start;
    output word_sync_valid_o;
    
    
    //------------------------signal declaration-------------------------------
    
    reg [DESER_FACTOR-1:0]rx_r0,rx_r1,rx_r2,rx_r3;
    reg [DESER_FACTOR-1:0]rx_rr0,rx_rr1,rx_rr2,rx_rr3;
    reg [DESER_FACTOR-1:0]rx_r4,rx_r5,rx_r6,rx_r7;
    reg [DESER_FACTOR-1:0]rx_rr4,rx_rr5,rx_rr6,rx_rr7;
    reg [DESER_FACTOR-1:0]rx_r8,rx_r9,rx_r10,rx_r11;
    reg [DESER_FACTOR-1:0]rx_rr8,rx_rr9,rx_rr10,rx_rr11;
    reg [DESER_FACTOR-1:0]sync_data0,sync_data1,sync_data2,sync_data3;
    reg [DESER_FACTOR-1:0]sync_data0_r,sync_data1_r,sync_data2_r,sync_data3_r;
    reg [DESER_FACTOR-1:0]sync_data4,sync_data5,sync_data6,sync_data7;
    reg [DESER_FACTOR-1:0]sync_data4_r,sync_data5_r,sync_data6_r,sync_data7_r;
    reg [DESER_FACTOR-1:0]sync_data11,sync_data8,sync_data9,sync_data10;
    reg [DESER_FACTOR-1:0]sync_data11_r,sync_data8_r,sync_data9_r,sync_data10_r;
    reg [DESER_FACTOR-1:0]sync_strobe,sync_strobe_r;
    reg [DESER_FACTOR-1:0]strobe_r,strobe_rr;
    
    wire [7:0]shift_bit;
    
    wire [bit_per_frame-1:0]default_strobe_case0;
    wire [bit_per_frame-1:0]shifted_strobe_case1;
    wire [bit_per_frame-1:0]shifted_strobe_case2;
    wire [bit_per_frame-1:0]shifted_strobe_case3;
    wire [bit_per_frame-1:0]shifted_strobe_case4;
    wire [bit_per_frame-1:0]shifted_strobe_case5;
    wire [bit_per_frame-1:0]shifted_strobe_case6;
    wire [bit_per_frame-1:0]shifted_strobe_case7;
    wire [bit_per_frame-1:0]concat_strobe;
    
    
    reg state_sync,n_state_sync;
    reg sync_done,n_sync_done;
    reg start_sync,fifo_wr_en,fifo_wr_en_r,fifo_wr_en_rr;
    reg n_start_sync,n_fifo_wr_en;
    
    wire fifo_wr_stop;
    wire fifo_wr_reset;
    
    reg [2:0]state_cap;
    reg [2:0]n_state_cap;
    reg [11:0]counter;
    reg [3:0]mux_case,n_mux_case;
    
    wire shift_0bit;// pulse detects the no. of bits slipped
    wire shift_1bit;// pulse detects the no. of bits slipped
    wire shift_2bit;// pulse detects the no. of bits slipped
    wire shift_3bit;// pulse detects the no. of bits slipped
    wire shift_4bit;// pulse detects the no. of bits slipped
    wire shift_5bit;// pulse detects the no. of bits slipped
    wire shift_6bit;// pulse detects the no. of bits slipped
    wire shift_7bit;// pulse detects the no. of bits slipped
    //-----------------------debug ports------------------------
    wire [7:0]strobe_i;
    wire bitslip_start;
    
    wire [7:0]  data0_db;
    wire [7:0]  data1_db;
    wire [7:0]  data2_db;
    wire [7:0]  data3_db;
    wire [7:0]  data4_db;
    wire [7:0]  data5_db;
    wire [7:0]  data6_db;
    wire [7:0]  data7_db;
    wire [7:0]  data8_db;
    wire [7:0]  data9_db;
    wire [7:0]  data10_db;
    wire [7:0]  data11_db;
    
    wire [2:0]  state_cap_db;
    wire [7:0]  dataout0_r_db;
    wire [7:0]  dataout1_r_db;
    wire [7:0]  dataout2_r_db;
    wire [7:0]  dataout3_r_db;
    wire [7:0]  dataout4_r_db;
    wire [7:0]  dataout5_r_db;
    wire [7:0]  dataout6_r_db;
    wire [7:0]  dataout7_r_db;
    wire [7:0]  dataout8_r_db;
    wire [7:0]  dataout9_r_db;
    wire [7:0]  dataout10_r_db;
    wire [7:0]  dataout11_r_db;
    
    wire [7:0]  sync_strobe_r_db;
    wire [3:0]  mux_case_db;
    wire        fifo_wr_en_db;
    wire        bitslip_start_db;
    wire        sync_done_db;
    wire        state_sync_db;
    wire        word_sync_valid_o;
                                                                        
    //---------------------------counter--------------------------
    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in)
            counter <= 12'd0;
        else if(fifo_wr_reset)
            counter <= 12'd0;
        else if(fifo_wr_en)
            counter <= counter + 12'd1;
        else 
            counter <= counter;
    end

// ----------------regestering data and strobe--------------------
    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in) 
        begin
            rx_r0        	 <= 8'd0;
            rx_rr0       	 <= 8'd0;
            rx_r1        	 <= 8'd0;
            rx_rr1       	 <= 8'd0;
            rx_r2        	 <= 8'd0;
            rx_rr2       	 <= 8'd0;
            rx_r3        	 <= 8'd0;
            rx_rr3       	 <= 8'd0;
            rx_r4        	 <= 8'd0;
            rx_rr4           <= 8'd0;
            rx_r5            <= 8'd0;
            rx_rr5           <= 8'd0;
            rx_r6            <= 8'd0;
            rx_rr6           <= 8'd0;
            rx_r7            <= 8'd0;
            rx_rr7           <= 8'd0;
            rx_r8            <= 8'd0;
            rx_rr8           <= 8'd0;
            rx_r9            <= 8'd0;
            rx_rr9           <= 8'd0;
            rx_r10           <= 8'd0;
            rx_rr10          <= 8'd0;
            rx_r11           <= 8'd0;
            rx_rr11          <= 8'd0;
            
            strobe_r      	 <= 8'd0;
            strobe_rr     	 <= 8'd0;
        
        end
	   else 
	   begin
            rx_r0        	 <= #pTCQ raw_data0_i;
            rx_rr0       	 <= rx_r0;
            rx_r1        	 <= #pTCQ raw_data1_i;
            rx_rr1       	 <= rx_r1;
            rx_r2        	 <= #pTCQ raw_data2_i;
            rx_rr2       	 <= rx_r2;
            rx_r3        	 <= #pTCQ raw_data3_i;
            rx_rr3       	 <= rx_r3;
            rx_r4        	 <= #pTCQ raw_data4_i;
            rx_rr4           <= rx_r4;
            rx_r5            <= #pTCQ raw_data5_i;
            rx_rr5           <= rx_r5;
            rx_r6            <= #pTCQ raw_data6_i;
            rx_rr6           <= rx_r6;
            rx_r7            <= #pTCQ raw_data7_i;
            rx_rr7           <= rx_r7;
            rx_r8            <= #pTCQ raw_data8_i;
            rx_rr8           <= rx_r8;
            rx_r9            <= #pTCQ raw_data9_i;
            rx_rr9           <= rx_r9;
            rx_r10           <= #pTCQ raw_data10_i;
            rx_rr10          <= rx_r10;
            rx_r11           <= #pTCQ raw_data11_i;
            rx_rr11          <= rx_r11;
            
            strobe_r      	 <= #pTCQ strobe_i;
            strobe_rr     	 <= strobe_r;
	   end
    end

    //detection of start and end of Calibration
    localparam  IDLE_cap             = 2'd0,
                SYNC_cap             = 2'd1,
                FIFO_STOP_cap        = 2'd2;

    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in)
        begin
            state_cap  	<= 3'd0;
            start_sync 	<= 1'b0;
        end
        else
        begin
            state_cap  	<= n_state_cap;
            start_sync 	<= n_start_sync;
        end
    end

    always @(*)
    begin
        n_state_cap 	= state_cap;
        n_start_sync 	= 1'b0;
        n_start_sync 	= 1'b0;
        
        case(state_cap)
    
          IDLE_cap:
            begin
                if(bitslip_start)
                begin
                    n_start_sync 	= 1'b1;
                    n_state_cap		= SYNC_cap;
                end
                else
                begin
                    n_start_sync 	= 1'b0;
                    n_state_cap		= IDLE_cap;
                end
            end 
          
          SYNC_cap :
            begin
                if(sync_done) 
                begin
                    n_state_cap 	= FIFO_STOP_cap;
                end
                else
                    n_state_cap 	= SYNC_cap;
            end
    
           FIFO_STOP_cap:
            begin
                if(fifo_wr_stop)//stop condition is commented
                begin
                    n_state_cap 	= IDLE_cap; // makes fifo wr enable to 0 and wait for next trigger
                end 
                else
                begin
                    n_state_cap 	= FIFO_STOP_cap;
                end
            end
        endcase
    end
// detection of valid no. of bits shifted in lanes
    always @(posedge clk or posedge rst_in)
    begin
        if(rst_in)
            begin
                state_sync 	<= 1'd0;
                mux_case 	<= 4'd0;
                sync_done 	<= 1'b0;
            end
            else
            begin
                state_sync 	<= n_state_sync;
                mux_case 	<= n_mux_case;
                sync_done 	<= n_sync_done;
            end
    end
    
    localparam IDLE_sync 		= 1'b0,
               PATTERN_CHECK 	= 1'b1;
                
    always@(*)
    begin
        n_state_sync 	= state_sync;
        n_mux_case 		= mux_case;
        n_sync_done 	= 1'b0;
        case(state_sync)
            IDLE_sync :
                begin
                    if(start_sync)
                        n_state_sync = PATTERN_CHECK;
                    else if(state_cap == IDLE_cap)
                    begin
                        n_state_sync = IDLE_sync;
                        n_mux_case	 = 4'd0;			//Reset mux case
                    end
                    else
                        n_state_sync = IDLE_sync;
                end
                
            PATTERN_CHECK :
                begin
                    case(shift_bit) //use concat_rrr
                        8'b00000001://LEFT_BITSHIFT_BY0 
                        begin
                            n_mux_case 		= 4'd1;      
                            n_state_sync 	= IDLE_sync; 
                            n_sync_done  	= 1'b1;      
                        end	        
                        8'b00000010: //LEFT_BITSHIFT_BY1
                        begin
                            n_mux_case 		= 4'd2;     
                            n_state_sync 	= IDLE_sync;
                            n_sync_done  	= 1'b1;     
                        end          
                        8'b00000100: //LEFT_BITSHIFT_BY2 
                        begin
                            n_mux_case 		= 4'd3;      
                            n_state_sync 	= IDLE_sync; 
                            n_sync_done  	= 1'b1;      
                        end
                         8'b00001000: //LEFT_BITSHIFT_BY3
                        begin
                            n_mux_case 		= 4'd4;
                            n_state_sync 	= IDLE_sync;
                            n_sync_done  	= 1'b1;
                        end 
                        8'b00010000: //LEFT_BITSHIFT_BY4
                        begin
                            n_mux_case 		= 4'd5;
                            n_state_sync 	= IDLE_sync;
                            n_sync_done  	= 1'b1;																		
                        end
                        8'b00100000: //LEFT_BITSHIFT_BY5
                        begin                        
                            n_mux_case 		= 4'd6;
                            n_state_sync 	= IDLE_sync;
                            n_sync_done  	= 1'b1;
                        end
                                        
                       8'b01000000: //LEFT_BITSHIFT_BY6
                        begin
                            n_mux_case 		= 4'd7;
                            n_state_sync 	= IDLE_sync;
                            n_sync_done  	= 1'b1;
                        end
                       8'b10000000: //LEFT_BITSHIFT_BY7
                        begin
                            n_mux_case 		= 4'd8;
                            n_state_sync 	= IDLE_sync;
                            n_sync_done  	= 1'b1;
                        end
                        default    :
                        begin
                            n_mux_case 		= 4'd0;	
                            n_state_sync 	= PATTERN_CHECK;
                            n_sync_done  	= 1'b0;
                        end
                     endcase
                 end
         endcase
    end

	always@(posedge clk or posedge rst_in) begin
		if(rst_in)begin
			sync_data0 		<= 8'd0; 
		    sync_data1      <= 8'd0;
		    sync_data2      <= 8'd0;
		    sync_data3      <= 8'd0;
		    sync_data4      <= 8'd0;
		    sync_data5      <= 8'd0;
		    sync_data6      <= 8'd0;
		    sync_data7      <= 8'd0;
		    sync_data8      <= 8'd0;
		    sync_data9      <= 8'd0;
		    sync_data10     <= 8'd0;
		    sync_data11     <= 8'd0;
		    sync_strobe     <= 8'd0;
		    fifo_wr_en      <= 1'd0;                         
		end
		else begin                     
                case(mux_case) 			
                4'd1: //LEFT_BITSHIFT_BY0
					begin
					        sync_data0   <= rx_r0;
							sync_data1   <= rx_r1;
							sync_data2   <= rx_r2;
							sync_data3   <= rx_r3; 
							sync_data4   <= rx_r4;
							sync_data5   <= rx_r5;
							sync_data6   <= rx_r6;
							sync_data7   <= rx_r7;
							sync_data8   <= rx_r8;
							sync_data9   <= rx_r9;
							sync_data10  <= rx_r10;
							sync_data11  <= rx_r11; 
							sync_strobe  <= strobe_r;
							fifo_wr_en   <= 1'b1; 
					end				                           
                4'd2: //LEFT_BITSHIFT_BY1 
					begin
							sync_data0  <= {rx_r0[6:0],rx_rr0[7]};
							sync_data1  <= {rx_r1[6:0],rx_rr1[7]};
							sync_data2  <= {rx_r2[6:0],rx_rr2[7]};
							sync_data3  <= {rx_r3[6:0],rx_rr3[7]};
							sync_data4  <= {rx_r4[6:0],rx_rr4[7]};
							sync_data5  <= {rx_r5[6:0],rx_rr5[7]};
							sync_data6  <= {rx_r6[6:0],rx_rr6[7]};
							sync_data7  <= {rx_r7[6:0],rx_rr7[7]};  
							sync_data8  <= {rx_r8[6:0],rx_rr8[7]};
							sync_data9  <= {rx_r9[6:0],rx_rr9[7]};
							sync_data10 <= {rx_r10[6:0],rx_rr10[7]};
							sync_data11 <= {rx_r11[6:0],rx_rr11[7]};  
							sync_strobe <= {strobe_r[6:0],strobe_rr[7]}; 
							fifo_wr_en  <= 1'b1;   
					end				                       
                4'd3: //LEFT_BITSHIFT_BY2
					begin
						    sync_data0  <= {rx_r0[5:0],rx_rr0[7:6]};
							sync_data1  <= {rx_r1[5:0],rx_rr1[7:6]};
							sync_data2  <= {rx_r2[5:0],rx_rr2[7:6]};
							sync_data3  <= {rx_r3[5:0],rx_rr3[7:6]};
							sync_data4  <= {rx_r4[5:0],rx_rr4[7:6]};
							sync_data5  <= {rx_r5[5:0],rx_rr5[7:6]};
							sync_data6  <= {rx_r6[5:0],rx_rr6[7:6]};
							sync_data7  <= {rx_r7[5:0],rx_rr7[7:6]};
							sync_data8  <= {rx_r8[5:0],rx_rr8[7:6]};
							sync_data9  <= {rx_r9[5:0],rx_rr9[7:6]};
							sync_data10 <= {rx_r10[5:0],rx_rr10[7:6]};
							sync_data11 <= {rx_r11[5:0],rx_rr11[7:6]}; 
							sync_strobe <= {strobe_r[5:0],strobe_rr[7:6]};
							fifo_wr_en  <= 1'b1;  
					end				
                      
                4'd4: //LEFT_BITSHIFT_BY3
					begin
							sync_data0  <= {rx_r0[4:0],rx_rr0[7:5]};
							sync_data1  <= {rx_r1[4:0],rx_rr1[7:5]};
							sync_data2  <= {rx_r2[4:0],rx_rr2[7:5]};
							sync_data3  <= {rx_r3[4:0],rx_rr3[7:5]}; 
							sync_data4  <= {rx_r4[4:0],rx_rr4[7:5]};
							sync_data5  <= {rx_r5[4:0],rx_rr5[7:5]};
							sync_data6  <= {rx_r6[4:0],rx_rr6[7:5]};
							sync_data7  <= {rx_r7[4:0],rx_rr7[7:5]}; 
							sync_data8  <= {rx_r8[4:0],rx_rr8[7:5]};
							sync_data9  <= {rx_r9[4:0],rx_rr9[7:5]};
							sync_data10 <= {rx_r10[4:0],rx_rr10[7:5]};
							sync_data11 <= {rx_r11[4:0],rx_rr11[7:5]};        
							sync_strobe <= {strobe_r[4:0],strobe_rr[7:5]};
							fifo_wr_en  <= 1'b1;   
					end
                4'd5: //LEFT_BITSHIFT_BY4
					begin
						    sync_data0  <= {rx_r0[3:0],rx_rr0[7:4]};
							sync_data1  <= {rx_r1[3:0],rx_rr1[7:4]};
							sync_data2  <= {rx_r2[3:0],rx_rr2[7:4]};
							sync_data3  <= {rx_r3[3:0],rx_rr3[7:4]}; 
							sync_data4  <= {rx_r4[3:0],rx_rr4[7:4]};
							sync_data5  <= {rx_r5[3:0],rx_rr5[7:4]};
							sync_data6  <= {rx_r6[3:0],rx_rr6[7:4]};
							sync_data7  <= {rx_r7[3:0],rx_rr7[7:4]}; 
							sync_data8  <= {rx_r8[3:0],rx_rr8[7:4]};
							sync_data9  <= {rx_r9[3:0],rx_rr9[7:4]};
							sync_data10 <= {rx_r10[3:0],rx_rr10[7:4]};
							sync_data11 <= {rx_r11[3:0],rx_rr11[7:4]};        
							sync_strobe <= {strobe_r[3:0],strobe_rr[7:4]};
							fifo_wr_en  <= 1'b1;  
					end
                4'd6: //LEFT_BITSHIFT_BY5
					begin
							sync_data0  <= {rx_r0[2:0],rx_rr0[7:3]};
							sync_data1  <= {rx_r1[2:0],rx_rr1[7:3]};
							sync_data2  <= {rx_r2[2:0],rx_rr2[7:3]};
							sync_data3  <= {rx_r3[2:0],rx_rr3[7:3]}; 
							sync_data4  <= {rx_r4[2:0],rx_rr4[7:3]};
							sync_data5  <= {rx_r5[2:0],rx_rr5[7:3]};
							sync_data6  <= {rx_r6[2:0],rx_rr6[7:3]};
							sync_data7  <= {rx_r7[2:0],rx_rr7[7:3]}; 
							sync_data8  <= {rx_r8[2:0],rx_rr8[7:3]};
							sync_data9  <= {rx_r9[2:0],rx_rr9[7:3]};
							sync_data10 <= {rx_r10[2:0],rx_rr10[7:3]};
							sync_data11 <= {rx_r11[2:0],rx_rr11[7:3]};        
							sync_strobe <= {strobe_r[2:0],strobe_rr[7:3]};
							fifo_wr_en  <=1'b1; 
					end
					
				4'd7: //LEFT_BITSHIFT_BY6
					begin
							sync_data0  <= {rx_r0[1:0],rx_rr0[7:2]};
							sync_data1  <= {rx_r1[1:0],rx_rr1[7:2]};
							sync_data2  <= {rx_r2[1:0],rx_rr2[7:2]};
							sync_data3  <= {rx_r3[1:0],rx_rr3[7:2]};
							sync_data4  <= {rx_r4[1:0],rx_rr4[7:2]};
							sync_data5  <= {rx_r5[1:0],rx_rr5[7:2]};
							sync_data6  <= {rx_r6[1:0],rx_rr6[7:2]};
							sync_data7  <= {rx_r7[1:0],rx_rr7[7:2]};
							sync_data8  <= {rx_r8[1:0],rx_rr8[7:2]};
							sync_data9  <= {rx_r9[1:0],rx_rr9[7:2]};
							sync_data10 <= {rx_r10[1:0],rx_rr10[7:2]};
							sync_data11 <= {rx_r11[1:0],rx_rr11[7:2]}; 
							sync_strobe <= {strobe_r[1:0],strobe_rr[7:2]};
							fifo_wr_en  <= 1'b1;   
					end
					
                4'd8: //LEFT_BITSHIFT_BY7
					begin
						    sync_data0  <= {rx_r0[0],rx_rr0[7:1]};        
							sync_data1  <= {rx_r1[0],rx_rr1[7:1]};        
							sync_data2  <= {rx_r2[0],rx_rr2[7:1]};
							sync_data3  <= {rx_r3[0],rx_rr3[7:1]}; 
							sync_data4  <= {rx_r4[0],rx_rr4[7:1]};
							sync_data5  <= {rx_r5[0],rx_rr5[7:1]};
							sync_data6  <= {rx_r6[0],rx_rr6[7:1]};
							sync_data7  <= {rx_r7[0],rx_rr7[7:1]}; 
							sync_data8  <= {rx_r8[0],rx_rr8[7:1]};
							sync_data9  <= {rx_r9[0],rx_rr9[7:1]};
							sync_data10 <= {rx_r10[0],rx_rr10[7:1]};
							sync_data11 <= {rx_r11[0],rx_rr11[7:1]};        
							sync_strobe <= {strobe_r[0],strobe_rr[7:1]};
							fifo_wr_en  <= 1'b1;
					end
                default:
					begin
						    sync_data0  <= rx_r0;
							sync_data1  <= rx_r1;
							sync_data2  <= rx_r2;
							sync_data3  <= rx_r3; 
							sync_data4  <= rx_r4;
							sync_data5  <= rx_r5;
							sync_data6  <= rx_r6;
							sync_data7  <= rx_r7; 
							sync_data8  <= rx_r8;
							sync_data9  <= rx_r9;
							sync_data10 <= rx_r10;
							sync_data11 <= rx_r11; 
							sync_strobe <= strobe_r;
							fifo_wr_en  <= 1'b0;    
					end
                endcase
        end 
	end
		
always @(posedge clk or posedge rst_in)begin
    if(rst_in) begin
        sync_data0_r   <= 8'd0;
        sync_data1_r   <= 8'd0;
        sync_data2_r   <= 8'd0;
        sync_data3_r   <= 8'd0;
        sync_data4_r   <= 8'd0;
        sync_data5_r   <= 8'd0;
        sync_data6_r   <= 8'd0;
        sync_data7_r   <= 8'd0;
        sync_data8_r   <= 8'd0;
        sync_data9_r   <= 8'd0;
        sync_data10_r  <= 8'd0;
        sync_data11_r  <= 8'd0;
        sync_strobe_r  <= 8'd0;
        fifo_wr_en_r   <= 1'd0;
        fifo_wr_en_rr  <= 1'd0;
    end
    else begin
        sync_data0_r   <= sync_data0;  // delaying for 1 clk cycle to compenstate with fifo_wr_en
        sync_data1_r   <= sync_data1;
        sync_data2_r   <= sync_data2;
        sync_data3_r   <= sync_data3;
        sync_data4_r   <= sync_data4; 
        sync_data5_r   <= sync_data5;
        sync_data6_r   <= sync_data6;
        sync_data7_r   <= sync_data7;
        sync_data8_r   <= sync_data8; 
        sync_data9_r   <= sync_data9;
        sync_data10_r  <= sync_data10;
        sync_data11_r  <= sync_data11;
        sync_strobe_r  <= sync_strobe;
        fifo_wr_en_r   <= fifo_wr_en;
        fifo_wr_en_rr  <= fifo_wr_en_r;
    end
end


//---------------------------assign statements---------------------
// possible shift condition
    assign default_strobe_case0 = STROBE_PATTERN;    							//1111_1111_0000_0000	   //1111_1111_0000_0000
    assign shifted_strobe_case1 = {STROBE_PATTERN[0],STROBE_PATTERN[15:1]}; 	//1111_1110_0000_0001      //0111_1111_1000_0000
    assign shifted_strobe_case2 = {STROBE_PATTERN[1:0],STROBE_PATTERN[15:2]}; //1111_1100_0000_0011      //0011_1111_1000_0000
    assign shifted_strobe_case3 = {STROBE_PATTERN[2:0],STROBE_PATTERN[15:3]}; //1111_1000_0000_0111      //0001_1111_1110_0000
    assign shifted_strobe_case4 = {STROBE_PATTERN[3:0],STROBE_PATTERN[15:4]}; //1111_0000_0000_1111      //0000_1111_1111_0000
    assign shifted_strobe_case5 = {STROBE_PATTERN[4:0],STROBE_PATTERN[15:5]}; //1110_0000_0001_1111      //0000_0111_1111_1000
    assign shifted_strobe_case6 = {STROBE_PATTERN[5:0],STROBE_PATTERN[15:6]}; 	//1100_0000_0011_1111      //0000_0011_1111_1100
    assign shifted_strobe_case7 = {STROBE_PATTERN[6:0],STROBE_PATTERN[15:7]}; 	//1000_0000_0111_1111      //0000_0001_1111_1110
    
    assign concat_strobe  		= {strobe_i,strobe_r};
    
    assign shift_bit[0] 		= (default_strobe_case0 == concat_strobe);	//no. of bits shifted detection
    assign shift_bit[1]	    	= (shifted_strobe_case1 == concat_strobe);	//no. of bits shifted detection	
    assign shift_bit[2] 		= (shifted_strobe_case2 == concat_strobe);    //no. of bits shifted detection    
    assign shift_bit[3]	    	= (shifted_strobe_case3 == concat_strobe);    //no. of bits shifted detection    
    assign shift_bit[4] 		= (shifted_strobe_case4 == concat_strobe);    //no. of bits shifted detection    
    assign shift_bit[5]	    	= (shifted_strobe_case5 == concat_strobe);    //no. of bits shifted detection    
    assign shift_bit[6] 		= (shifted_strobe_case6 == concat_strobe);    //no. of bits shifted detection    
    assign shift_bit[7]	    	= (shifted_strobe_case7 == concat_strobe);    //no. of bits shifted detection    

//counter reset assignments
    assign fifo_wr_stop       	= (counter == 12'd2046);	//actual len - 2
    assign fifo_wr_reset      	= (counter == 12'd1000);  //for continous monitor,not allowing fifo to reach 2046	

//output data assignments
    assign word_sync_data0_o 	= sync_data0_r; 
    assign word_sync_data1_o 	= sync_data1_r; 
    assign word_sync_data2_o 	= sync_data2_r;
    assign word_sync_data3_o 	= sync_data3_r;
    assign word_sync_data4_o 	= sync_data4_r; 
    assign word_sync_data5_o 	= sync_data5_r; 
    assign word_sync_data6_o 	= sync_data6_r;
    assign word_sync_data7_o 	= sync_data7_r;
    assign word_sync_data8_o 	= sync_data8_r; 
    assign word_sync_data9_o 	= sync_data9_r; 
    assign word_sync_data10_o	= sync_data10_r;
    assign word_sync_data11_o	= sync_data11_r;
    assign word_sync_strobe_o 	= sync_strobe_r;
    assign word_sync_valid_o    = fifo_wr_en_rr;//changed by bala from rr to r
                                                                                
//debug signals
    assign data0_db    			= raw_data0_i;
    assign data1_db    			= raw_data1_i;
    assign data2_db    			= raw_data2_i;
    assign data3_db    			= raw_data3_i;
    assign data4_db    			= raw_data4_i;
    assign data5_db    			= raw_data5_i;
    assign data6_db    			= raw_data6_i;
    assign data7_db    			= raw_data7_i;
    assign data8_db    			= raw_data8_i;
    assign data9_db    			= raw_data9_i;
    assign data10_db   			= raw_data10_i;
    assign data11_db   			= raw_data11_i;
	
    assign fifo_wr_en_db    	= fifo_wr_en_r;
    assign mux_case_db      	= mux_case;
    assign bitslip_start_db 	= start_sync;
    assign sync_done_db     	= sync_done;
    assign dataout0_r_db   		= sync_data0_r;
    assign dataout1_r_db   		= sync_data1_r;
    assign dataout2_r_db   		= sync_data2_r;
    assign dataout3_r_db   		= sync_data3_r;
    assign dataout4_r_db   		= sync_data4_r;
    assign dataout5_r_db   		= sync_data5_r;
    assign dataout6_r_db   		= sync_data6_r;
    assign dataout7_r_db   		= sync_data7_r;
    assign dataout8_r_db   		= sync_data8_r;
    assign dataout9_r_db   		= sync_data9_r;
    assign dataout10_r_db  		= sync_data10_r;
    assign dataout11_r_db  		= sync_data11_r;
    assign sync_strobe_r_db		= sync_strobe_r;
    assign state_sync_db   		= state_sync;
    assign state_cap_db     	= state_cap;
	
endmodule