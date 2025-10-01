`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Soliton technologies
// Engineer: 
// 
// Create Date: 12/11/2017 02:09:19 PM
// Design Name: LRX
// Module Name: rx_channel_2
// Project Name: WBLVDS
// Target Devices: TSW14DL3200
// Tool Versions: 2017.1
// Description: 
//      Contains the HSSIO IP Instance for Bank0 and all associated signals and USER Fifo.
// Dependencies: edge_detection,bitslip,riu_if_iodelay,lane_sync,word_align,iodelay_n_metastab_chk
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rx_bus2
    #(  parameter   RIU_RST_FANOUT  =   8'd2,
        parameter   APP_RST_FANOUT  =   8'd30,
        parameter   STROBE_PAT1 	=   8'h00,  
        parameter   STROBE_PAT2 	=   8'h80  
    )
    (
	//clock and reset signals
    input                           app_clk,				//clk for data to be captured from the IP
    input                           riu_clk,				
    input   [APP_RST_FANOUT-1:0]    sw_rst_app,         	//sw_rst wrt app_clk - from clock manager
    input   [RIU_RST_FANOUT-1:0]    sw_rst_riu,         	//sw_rst wrt riu_clk - from clock manager
	
	//ADC signals
    input                           strobe_rx_p,			
    input                           strobe_rx_n,            
    input                           rx_clk_p,               
    input                           rx_clk_n,               
    input   [11:0]                  rx_data_p,              
    input   [11:0]                  rx_data_n,              

	//IP multi bank interface signals	
    input                           hssio_multi_intf_lock_in,	//multi bank pll locked 
    input                           hssio_multi_intf_rdy_in, 	// multi bank interface ready
    output                          hssio_fifo_rd_en_out,
    input                           hssio_mult_fifo_rd_en, 		// IP in-built fifo rd enable 
    output                          hssio_intf_rdy, 			//HSSIO IP interface ready
    output                          hssio_pll0_locked, 			//HSSIO IP pll lock

    output                          deser_clk_o, 				//HSSIO IP pll clk out 0
	
	//User fifo signal
    input                           fifo_rd_en,				    //user fifo rd enable        
    output  [103:0]                 fifo_data_out, 				//ADC captured data out from user fifo
    output                          fifo_empty,					//user fifo empty
    output                          fifo_valid,					//user fifo valid
	
	//control signals
    output                          lane_rdy, 					// Signal to indicate lane sync completion 
	input                           rx_start_sync, 				// signal to trigger bitslip calibration
	
	//IO delay ctrl, status registers    
    input   [31:0]                  iod_ctrl_reg1,  
    input   [31:0]                  iod_ctrl_reg2,  
    input   [31:0]                  iod_ctrl_reg3,  
    input   [31:0]                  iod_ctrl_reg4,  
    input   [31:0]                  iod_ctrl_reg5,  
    input   [31:0]                  iod_ctrl_reg6,  
    input   [31:0]                  iod_ctrl_reg7,  
    input   [31:0]                  iod_ctrl_reg8,  
        
    output                          iod_rst_ctrl_reg1,  //reset ctrl registers
    output                          iod_rst_ctrl_reg2,  //reset ctrl registers
    output                          iod_rst_ctrl_reg3,  //reset ctrl registers
    output                          iod_rst_ctrl_reg4,  //reset ctrl registers
    output                          iod_rst_ctrl_reg5,  //reset ctrl registers
    output                          iod_rst_ctrl_reg6,  //reset ctrl registers
    output                          iod_rst_ctrl_reg7,  //reset ctrl registers
    output                          iod_rst_ctrl_reg8,
    
    output  [31:0]                  iod_status_reg1, 
    output  [31:0]                  iod_status_reg2,  
    output  [31:0]                  iod_status_reg3,  
    output  [31:0]                  iod_status_reg4,  
    output  [31:0]                  iod_status_reg5,  
    output  [31:0]                  iod_status_reg6,  
    output  [31:0]                  iod_status_reg7,  
    output  [31:0]                  iod_status_reg8
    );
    

    localparam  DESER_FACTOR        =   4'd8;   //deserialization factor
    localparam  NUM_OF_LANES        =   4'd12;
    localparam  WREN_CNTL_LANE      =   4'd0;   //lane from which data_valid_o[] signal will be connected to fifo_wr_en
    localparam  STRB_CNTL_LANE      =   4'd0;   //lane from which the strobe is connected to FIFO   
    
   //HSSIO IP signals decalartions
    wire            	  hssio_vtc_rdy_err_db,
						  hssio_dly_rdy_err_db,
						  pll0_clkout0,
						  hssio_rst_seq_done,
						  hssio_en_vtc_bsc_in,
						  lane_valid,
						  hssio_vtc_rdy,
						  hssio_dly_rdy,
						  hssio_fifo_not_empty,
						  hssio_intf_rdy_riu,
						  hssio_multi_intf_rdy_in_deser;
		                  
    wire    [12:0]  	  hssio_fifo_empty;
		                  
    wire    [7:0]   	  data_to_fabric_strobe_rx_p,          
						  data_to_fabric_rx_data0_p,  data_to_fabric_rx_data1_p,  data_to_fabric_rx_data2_p,  data_to_fabric_rx_data3_p,  
						  data_to_fabric_rx_data4_p,  data_to_fabric_rx_data5_p,  data_to_fabric_rx_data6_p,  data_to_fabric_rx_data7_p,   
						  data_to_fabric_rx_data8_p,  data_to_fabric_rx_data9_p,  data_to_fabric_rx_data10_p, data_to_fabric_rx_data11_p;    
		                  
    wire    [6:0]   	  hssio_vtc_rdy_bsc,
						  hssio_dly_rdy_bsc;
						  
    reg             	  hssio_dly_rdy_err,
						  hssio_vtc_rdy_err,
						  hssio_en_vtc_bsc_in_riu,
						  hssio_fifo_rd_en;
    
    //User FIFO Decalartions    
    wire    [103:0] 	  fifo_data_o,
						  fifo_data_i;
    
    //bitslip submodule declarations
    reg [NUM_OF_LANES-1:0] [DESER_FACTOR-1:0] bitslip_data_o;
    reg [DESER_FACTOR-1:0]bitslip_strobe_o;
    reg 				  start_bitslip,
						  bitslip_done;
	wire				  start_bitslip_pulse;
    
    //lane-sync submodule declarations
    reg 				  usr_fifo_wren;
    reg [NUM_OF_LANES-1:0] [DESER_FACTOR-1:0]       lane_sync_data_o,
                                                    word_align_data_o;
    reg [NUM_OF_LANES-1:0] [DESER_FACTOR-1:0]       lane_sync_strobe_o;
    reg [NUM_OF_LANES-1:0] [DESER_FACTOR-1:0]       word_align_strobe_o;
    reg [NUM_OF_LANES-1:0]                          data_valid_o,
                                                    word_valid_o;
													
    reg     			  valid_misalign;                  
    wire    			  lane_valid_db;   

    // IO Delay declarations 
    //RIU Interface for IO Delay  
    wire    [3:0][15:0]   riu_rd_data_bg;
    wire    [5:0]         riu_addr_bg;      
    wire    [1:0]         riu_nibble_sel_bg;
    wire    [5:0]         ctrl_reg_addr;
    wire    [1:0]         ctrl_reg_bg;
    wire                  ctrl_reg_nib;
    wire                  trig_riu_iodelay,
						  trig_riu_iodelay_re;
    wire    [15:0]        riu_if_rd_data;
    wire                  riu_if_rd_done;
    wire                  multi_riu_valid_bg;     
    wire    [3:0]         riu_valid_bg;
    
     //IO Delay Interface
    wire 	[12:0]        rx_en_vtc_iod,
                          inc_iod,
                      	  ce_iod,
                      	  load_iod,
                      	  rx_dly_rdy_iod,
                      	  rx_vtc_rdy_iod;
    
    wire 	[12:0][8:0]   cntvalue_in_iod,
                      	  cntvalue_out_iod;
       
    wire    [12:0][15:0]  ctrl_lane;  //52 lanes = 48 data lanes + 4 strb lanes, each needs 16 bits for ctrl
    wire    [12:0][15:0]  status_lane; //52 lanes = 48 data lanes + 4 strb lanes, each needs 16 bits for status  
    wire    [12:0][7:0]   lane_data;
    wire    [12:0]        rst_ctrl_lane;
    wire                  rst_ctrl_reg_riu;
        
	//IP Instance                
    rx2_Bank24 rx2_i (
        .rx_cntvaluein_0                (cntvalue_in_iod    [5]),                         // input wire [8 : 0] rx_cntvaluein_0
        .rx_cntvalueout_0               (cntvalue_out_iod   [5]),                        // output wire [8 : 0] rx_cntvalueout_0
        .rx_ce_0                        (ce_iod             [5]),                                 // input wire rx_ce_0
        .rx_inc_0                       (inc_iod            [5]),                                // input wire rx_inc_0
        .rx_load_0                      (load_iod           [5]),                               // input wire rx_load_0
        .rx_en_vtc_0                    (rx_en_vtc_iod      [5]),                             // input wire rx_en_vtc_0
        
        .rx_cntvaluein_2                (cntvalue_in_iod    [11]),                         // input wire [8 : 0] rx_cntvaluein_2
        .rx_cntvalueout_2               (cntvalue_out_iod   [11]),                        // output wire [8 : 0] rx_cntvalueout_2
        .rx_ce_2                        (ce_iod             [11]),                                 // input wire rx_ce_2
        .rx_inc_2                       (inc_iod            [11]),                                // input wire rx_inc_2
        .rx_load_2                      (load_iod           [11]),                               // input wire rx_load_2
        .rx_en_vtc_2                    (rx_en_vtc_iod      [11]),                             // input wire rx_en_vtc_2
        
        .rx_cntvaluein_10               (cntvalue_in_iod    [9]),                       // input wire [8 : 0] rx_cntvaluein_10
        .rx_cntvalueout_10              (cntvalue_out_iod   [9]),                      // output wire [8 : 0] rx_cntvalueout_10
        .rx_ce_10                       (ce_iod             [9]),                               // input wire rx_ce_10
        .rx_inc_10                      (inc_iod            [9]),                              // input wire rx_inc_10
        .rx_load_10                     (load_iod           [9]),                             // input wire rx_load_10
        .rx_en_vtc_10                   (rx_en_vtc_iod      [9]),                           // input wire rx_en_vtc_10
        
        .rx_cntvaluein_13               (cntvalue_in_iod    [0]),                       // input wire [8 : 0] rx_cntvaluein_13
        .rx_cntvalueout_13              (cntvalue_out_iod   [0]),                      // output wire [8 : 0] rx_cntvalueout_13
        .rx_ce_13                       (ce_iod             [0]),                               // input wire rx_ce_13
        .rx_inc_13                      (inc_iod            [0]),                              // input wire rx_inc_13
        .rx_load_13                     (load_iod           [0]),                             // input wire rx_load_13
        .rx_en_vtc_13                   (rx_en_vtc_iod      [0]),                           // input wire rx_en_vtc_13 
        
        .rx_cntvaluein_15               (cntvalue_in_iod    [7]),                       // input wire [8 : 0] rx_cntvaluein_15 
        .rx_cntvalueout_15              (cntvalue_out_iod   [7]),                      // output wire [8 : 0] rx_cntvalueout_15 
        .rx_ce_15                       (ce_iod             [7]),                               // input wire rx_ce_15 
        .rx_inc_15                      (inc_iod            [7]),                              // input wire rx_inc_15 
        .rx_load_15                     (load_iod           [7]),                             // input wire rx_load_15 
        .rx_en_vtc_15                   (rx_en_vtc_iod      [7]),                           // input wire rx_en_vtc_15 
        
        .rx_cntvaluein_17               (cntvalue_in_iod    [6]),                       // input wire [8 : 0] rx_cntvaluein_17 
        .rx_cntvalueout_17              (cntvalue_out_iod   [6]),                      // output wire [8 : 0] rx_cntvalueout_17 
        .rx_ce_17                       (ce_iod             [6]),                               // input wire rx_ce_17 
        .rx_inc_17                      (inc_iod            [6]),                              // input wire rx_inc_17 
        .rx_load_17                     (load_iod           [6]),                             // input wire rx_load_17 
        .rx_en_vtc_17                   (rx_en_vtc_iod      [6]),                           // input wire rx_en_vtc_17
         
        .rx_cntvaluein_21               (cntvalue_in_iod    [8]),                       // input wire [8 : 0] rx_cntvaluein_21 
        .rx_cntvalueout_21              (cntvalue_out_iod   [8]),                      // output wire [8 : 0] rx_cntvalueout_21 
        .rx_ce_21                       (ce_iod             [8]),                               // input wire rx_ce_21 
        .rx_inc_21                      (inc_iod            [8]),                              // input wire rx_inc_21 
        .rx_load_21                     (load_iod           [8]),                             // input wire rx_load_21 
        .rx_en_vtc_21                   (rx_en_vtc_iod      [8]),                           // input wire rx_en_vtc_21 
        
        .rx_cntvaluein_23               (cntvalue_in_iod    [10]),                       // input wire [8 : 0] rx_cntvaluein_23 
        .rx_cntvalueout_23              (cntvalue_out_iod   [10]),                      // output wire [8 : 0] rx_cntvalueout_23 
        .rx_ce_23                       (ce_iod             [10]),                               // input wire rx_ce_23 
        .rx_inc_23                      (inc_iod            [10]),                              // input wire rx_inc_23 
        .rx_load_23                     (load_iod           [10]),                             // input wire rx_load_23 
        .rx_en_vtc_23                   (rx_en_vtc_iod      [10]),                           // input wire rx_en_vtc_23 
        
        .rx_cntvaluein_28               (cntvalue_in_iod    [12]),                       // input wire [8 : 0] rx_cntvaluein_28 
        .rx_cntvalueout_28              (cntvalue_out_iod   [12]),                      // output wire [8 : 0] rx_cntvalueout_28 
        .rx_ce_28                       (ce_iod             [12]),                               // input wire rx_ce_28 
        .rx_inc_28                      (inc_iod            [12]),                              // input wire rx_inc_28 
        .rx_load_28                     (load_iod           [12]),                             // input wire rx_load_28 
        .rx_en_vtc_28                   (rx_en_vtc_iod      [12]),                           // input wire rx_en_vtc_28 
        
        .rx_cntvaluein_30               (cntvalue_in_iod    [4]),                       // input wire [8 : 0] rx_cntvaluein_30 
        .rx_cntvalueout_30              (cntvalue_out_iod   [4]),                      // output wire [8 : 0] rx_cntvalueout_30 
        .rx_ce_30                       (ce_iod             [4]),                               // input wire rx_ce_30 
        .rx_inc_30                      (inc_iod            [4]),                              // input wire rx_inc_30 
        .rx_load_30                     (load_iod           [4]),                             // input wire rx_load_30 
        .rx_en_vtc_30                   (rx_en_vtc_iod      [4]),                           // input wire rx_en_vtc_30 
        
        .rx_cntvaluein_32               (cntvalue_in_iod    [2]),                       // input wire [8 : 0] rx_cntvaluein_32 
        .rx_cntvalueout_32              (cntvalue_out_iod   [2]),                      // output wire [8 : 0] rx_cntvalueout_32 
        .rx_ce_32                       (ce_iod             [2]),                               // input wire rx_ce_32 
        .rx_inc_32                      (inc_iod            [2]),                              // input wire rx_inc_32 
        .rx_load_32                     (load_iod           [2]),                             // input wire rx_load_32 
        .rx_en_vtc_32                   (rx_en_vtc_iod      [2]),                           // input wire rx_en_vtc_32 
        
        .rx_cntvaluein_34               (cntvalue_in_iod    [3]),                       // input wire [8 : 0] rx_cntvaluein_34 
        .rx_cntvalueout_34              (cntvalue_out_iod   [3]),                      // output wire [8 : 0] rx_cntvalueout_34 
        .rx_ce_34                       (ce_iod             [3]),                               // input wire rx_ce_34 
        .rx_inc_34                      (inc_iod            [3]),                              // input wire rx_inc_34 
        .rx_load_34                     (load_iod           [3]),                             // input wire rx_load_34 
        .rx_en_vtc_34                   (rx_en_vtc_iod      [3]),                           // input wire rx_en_vtc_34 
        
        .rx_cntvaluein_36               (cntvalue_in_iod    [1]),                       // input wire [8 : 0] rx_cntvaluein_36 
        .rx_cntvalueout_36              (cntvalue_out_iod   [1]),                      // output wire [8 : 0] rx_cntvalueout_36 
        .rx_ce_36                       (ce_iod             [1]),                               // input wire rx_ce_36 
        .rx_inc_36                      (inc_iod            [1]),                              // input wire rx_inc_36 
        .rx_load_36                     (load_iod           [1]),                             // input wire rx_load_36 
        .rx_en_vtc_36                   (rx_en_vtc_iod      [1]),                           // input wire rx_en_vtc_36 
        
        .rx_clk                         (riu_clk),                                            // input wire rx_clk 
        
        .riu_rd_data_bg0                (riu_rd_data_bg[0]),                        // output wire [15 : 0] riu_rd_data_bg0
        .riu_valid_bg0                  (riu_valid_bg[0]),                            // output wire riu_valid_bg0
        .riu_addr_bg0                   (riu_addr_bg),                              // input wire [5 : 0] riu_addr_bg0
        .riu_nibble_sel_bg0             (riu_nibble_sel_bg),                  // input wire [1 : 0] riu_nibble_sel_bg0
        .riu_wr_data_bg0                (16'b0),                     // input wire [15 : 0] riu_wr_data_bg0
        .riu_wr_en_bg0                  (1'b0),                       // input wire riu_wr_en_bg0
        
        .riu_rd_data_bg1                (riu_rd_data_bg[1]),                       // output wire [15 : 0] riu_rd_data_bg1
        .riu_valid_bg1                  (riu_valid_bg[1]),                           // output wire riu_valid_bg1
        .riu_addr_bg1                   (riu_addr_bg),                             // input wire [5 : 0] riu_addr_bg1
        .riu_nibble_sel_bg1             (riu_nibble_sel_bg),                 // input wire [1 : 0] riu_nibble_sel_bg1
        .riu_wr_data_bg1                (16'b0),                                   // input wire [15 : 0] riu_wr_data_bg1
        .riu_wr_en_bg1                  (1'b0),                                      // input wire riu_wr_en_bg1
        
        .riu_rd_data_bg2                (riu_rd_data_bg[2]),                        // output wire [15 : 0] riu_rd_data_bg2
        .riu_valid_bg2                  (riu_valid_bg[2]),                            // output wire riu_valid_bg2
        .riu_addr_bg2                   (riu_addr_bg),                              // input wire [5 : 0] riu_addr_bg2
        .riu_nibble_sel_bg2             (riu_nibble_sel_bg),                  // input wire [1 : 0] riu_nibble_sel_bg2
        .riu_wr_data_bg2                (16'b0),                                    // input wire [15 : 0] riu_wr_data_bg2
        .riu_wr_en_bg2                  (1'b0),                                       // input wire riu_wr_en_bg2
                        
        .fifo_rd_clk_0                  (app_clk),                            // input wire fifo_rd_clk_0
        .fifo_rd_clk_2                  (app_clk),                            // input wire fifo_rd_clk_2
        .fifo_rd_clk_10                 (app_clk),                          // input wire fifo_rd_clk_10
        .fifo_rd_clk_13                 (app_clk),                          // input wire fifo_rd_clk_13
        .fifo_rd_clk_15                 (app_clk),                          // input wire fifo_rd_clk_15
        .fifo_rd_clk_17                 (app_clk),                          // input wire fifo_rd_clk_17
        .fifo_rd_clk_21                 (app_clk),                          // input wire fifo_rd_clk_21
        .fifo_rd_clk_23                 (app_clk),                          // input wire fifo_rd_clk_23
        .fifo_rd_clk_28                 (app_clk),                          // input wire fifo_rd_clk_28
        .fifo_rd_clk_30                 (app_clk),                          // input wire fifo_rd_clk_30
        .fifo_rd_clk_32                 (app_clk),                          // input wire fifo_rd_clk_32
        .fifo_rd_clk_34                 (app_clk),                          // input wire fifo_rd_clk_34
        .fifo_rd_clk_36                 (app_clk),                          // input wire fifo_rd_clk_36
        
        .fifo_rd_en_0                   (hssio_fifo_rd_en),                              // input wire fifo_rd_en_0
        .fifo_rd_en_2                   (hssio_fifo_rd_en),                              // input wire fifo_rd_en_2
        .fifo_rd_en_10                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_10
        .fifo_rd_en_13                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_13
        .fifo_rd_en_15                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_15
        .fifo_rd_en_17                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_17
        .fifo_rd_en_21                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_21
        .fifo_rd_en_23                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_23
        .fifo_rd_en_28                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_28
        .fifo_rd_en_30                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_30
        .fifo_rd_en_32                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_32
        .fifo_rd_en_34                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_34
        .fifo_rd_en_36                  (hssio_fifo_rd_en),                            // input wire fifo_rd_en_36
        
        .fifo_empty_0                   (hssio_fifo_empty[0]),                              // output wire fifo_empty_0
        .fifo_empty_2                   (hssio_fifo_empty[1]),                              // output wire fifo_empty_2
        .fifo_empty_10                  (hssio_fifo_empty[2]),                            // output wire fifo_empty_10
        .fifo_empty_13                  (hssio_fifo_empty[3]),                            // output wire fifo_empty_13
        .fifo_empty_15                  (hssio_fifo_empty[4]),                            // output wire fifo_empty_15
        .fifo_empty_17                  (hssio_fifo_empty[5]),                            // output wire fifo_empty_17
        .fifo_empty_21                  (hssio_fifo_empty[6]),                            // output wire fifo_empty_21
        .fifo_empty_23                  (hssio_fifo_empty[7]),                            // output wire fifo_empty_23
        .fifo_empty_28                  (hssio_fifo_empty[8]),                            // output wire fifo_empty_28
        .fifo_empty_30                  (hssio_fifo_empty[9]),                            // output wire fifo_empty_30
        .fifo_empty_32                  (hssio_fifo_empty[10]),                            // output wire fifo_empty_32
        .fifo_empty_34                  (hssio_fifo_empty[11]),                            // output wire fifo_empty_34
        .fifo_empty_36                  (hssio_fifo_empty[12]),                            // output wire fifo_empty_36
        
          
        .en_vtc_bsc0                    (hssio_en_vtc_bsc_in_riu),                                // input wire en_vtc_bsc0
        .en_vtc_bsc1                    (hssio_en_vtc_bsc_in_riu),                                // input wire en_vtc_bsc1
        .en_vtc_bsc2                    (hssio_en_vtc_bsc_in_riu),                                // input wire en_vtc_bsc2
        .en_vtc_bsc3                    (hssio_en_vtc_bsc_in_riu),                                // input wire en_vtc_bsc3
        .en_vtc_bsc4                    (hssio_en_vtc_bsc_in_riu),                                // input wire en_vtc_bsc4
        .en_vtc_bsc5                    (hssio_en_vtc_bsc_in_riu),                                // input wire en_vtc_bsc5
       
        .vtc_rdy_bsc0                   (hssio_vtc_rdy_bsc[0]),                              // output wire vtc_rdy_bsc0
        .vtc_rdy_bsc1                   (hssio_vtc_rdy_bsc[1]),                              // output wire vtc_rdy_bsc1
        .vtc_rdy_bsc2                   (hssio_vtc_rdy_bsc[2]),                              // output wire vtc_rdy_bsc2
        .vtc_rdy_bsc3                   (hssio_vtc_rdy_bsc[3]),                              // output wire vtc_rdy_bsc3
        .vtc_rdy_bsc4                   (hssio_vtc_rdy_bsc[4]),                              // output wire vtc_rdy_bsc4
        .vtc_rdy_bsc5                   (hssio_vtc_rdy_bsc[5]),                              // output wire vtc_rdy_bsc5
             
        .dly_rdy_bsc0                   (hssio_dly_rdy_bsc[0]),                              // output wire dly_rdy_bsc0
        .dly_rdy_bsc1                   (hssio_dly_rdy_bsc[1]),                              // output wire dly_rdy_bsc1
        .dly_rdy_bsc2                   (hssio_dly_rdy_bsc[2]),                              // output wire dly_rdy_bsc2
        .dly_rdy_bsc3                   (hssio_dly_rdy_bsc[3]),                              // output wire dly_rdy_bsc3
        .dly_rdy_bsc4                   (hssio_dly_rdy_bsc[4]),                              // output wire dly_rdy_bsc4
        .dly_rdy_bsc5                   (hssio_dly_rdy_bsc[5]),                              // output wire dly_rdy_bsc5
                                         
        .rst_seq_done                   (hssio_rst_seq_done),                              // output wire rst_seq_done
        .shared_pll0_clkoutphy_out      (),                                     // output wire shared_pll0_clkoutphy_out
        
        .app_clk                        (app_clk),                                        // input wire app_clk
        .multi_intf_lock_in             (hssio_multi_intf_lock_in),                  // input wire multi_intf_lock_in
        .intf_rdy                       (hssio_intf_rdy),                                      // output wire intf_rdy
        
        .pll0_clkout0                   (pll0_clkout0),                              // output wire pll0_clkout0
        .rst                            (sw_rst_riu[0]),                                // input wire rst sw_rst_riu[12] from sw_rst_riu_r16
        .clk_p                          (rx_clk_p),                                            // input wire clk_p
        .clk_n                          (rx_clk_n),                                            // input wire clk_n
        .riu_clk                        (riu_clk),                                        // input wire riu_clk
        .pll0_locked                    (hssio_pll0_locked),                                // output wire pll0_locked
        
        .strobe_rx_p                    (strobe_rx_p),                       // input wire strobe_rx0_p
        .strobe_rx_n                    (strobe_rx_n),                       // input wire strobe_rx0_n
        .rx_data0_p                     (rx_data_p[0]),                         // input wire rx_data0_p
        .rx_data0_n                     (rx_data_n[0]),                         // input wire rx_data0_n
        .rx_data1_p                     (rx_data_p[1]),                         // input wire rx_data1_p
        .rx_data1_n                     (rx_data_n[1]),                         // input wire rx_data1_n
        .rx_data2_p                     (rx_data_p[2]),                         // input wire rx_data2_p
        .rx_data2_n                     (rx_data_n[2]),                         // input wire rx_data2_n
        .rx_data3_p                     (rx_data_p[3]),                         // input wire rx_data3_p
        .rx_data3_n                     (rx_data_n[3]),                         // input wire rx_data3_n
        .rx_data4_p                     (rx_data_p[4]),                         // input wire rx_data4_p
        .rx_data4_n                     (rx_data_n[4]),                         // input wire rx_data4_n
        .rx_data5_p                     (rx_data_p[5]),                         // input wire rx_data5_p
        .rx_data5_n                     (rx_data_n[5]),                         // input wire rx_data5_n
        .rx_data6_p                     (rx_data_p[6]),                         // input wire rx_data6_p
        .rx_data6_n                     (rx_data_n[6]),                         // input wire rx_data6_n
        .rx_data7_p                     (rx_data_p[7]),                         // input wire rx_data7_p
        .rx_data7_n                     (rx_data_n[7]),                         // input wire rx_data7_n 
        .rx_data8_p                     (rx_data_p[8]),                         // input wire rx_data8_p
        .rx_data8_n                     (rx_data_n[8]),                         // input wire rx_data8_n
        .rx_data9_p                     (rx_data_p[9]),                         // input wire rx_data9_p
        .rx_data9_n                     (rx_data_n[9]),                         // input wire rx_data9_n  
        .rx_data10_p                    (rx_data_p[10]),                        // input wire rx_data10_p 
        .rx_data10_n                    (rx_data_n[10]),                        // input wire rx_data10_n
        .rx_data11_p                    (rx_data_p[11]),                        // input wire rx_data11_p
        .rx_data11_n                    (rx_data_n[11]),                        // input wire rx_data11_n
       
        .data_to_fabric_strobe_rx_p     (data_to_fabric_strobe_rx_p),           // output wire [7: 0] data_to_fabric_strobe_rx0_p
        .data_to_fabric_rx_data0_p      (data_to_fabric_rx_data0_p),            // output wire [7: 0] data_to_fabric_rx_data0_p
        .data_to_fabric_rx_data1_p      (data_to_fabric_rx_data1_p),            // output wire [7: 0] data_to_fabric_rx_data1_p
        .data_to_fabric_rx_data2_p      (data_to_fabric_rx_data2_p),            // output wire [7: 0] data_to_fabric_rx_data2_p
        .data_to_fabric_rx_data3_p      (data_to_fabric_rx_data3_p),            // output wire [7: 0] data_to_fabric_rx_data3_p
        .data_to_fabric_rx_data4_p      (data_to_fabric_rx_data4_p),            // output wire [7 : 0] data_to_fabric_rx_data4_p
        .data_to_fabric_rx_data5_p      (data_to_fabric_rx_data5_p),            // output wire [7 : 0] data_to_fabric_rx_data5_p
        .data_to_fabric_rx_data6_p      (data_to_fabric_rx_data6_p),            // output wire [7 : 0] data_to_fabric_rx_data6_p
        .data_to_fabric_rx_data7_p      (data_to_fabric_rx_data7_p),            // output wire [7 : 0] data_to_fabric_rx_data7_p
        .data_to_fabric_rx_data8_p      (data_to_fabric_rx_data8_p),            // output wire [7 : 0] data_to_fabric_rx_data8_p
        .data_to_fabric_rx_data9_p      (data_to_fabric_rx_data9_p),            // output wire [7 : 0] data_to_fabric_rx_data9_p
        .data_to_fabric_rx_data10_p     (data_to_fabric_rx_data10_p),           // output wire [7 : 0] data_to_fabric_rx_data10_p
        .data_to_fabric_rx_data11_p     (data_to_fabric_rx_data11_p)            // output wire [7 : 0] data_to_fabric_rx_data11_p
    );
    
    //In order to utilize global routing for pll0_clkout0 ,BUFG is used
    BUFG pll_bufg   (
       .O  (deser_clk_o),
       .I  (pll0_clkout0)
    );

	// edge detection - Start bitslip 
    rise_fal_edge bitslip_start(
        .clk_in          (app_clk)  ,    //input clk
        .rst_in           (sw_rst_app[25]) ,    //active high rst
        .signal_in        (start_bitslip),    //1b signal to which rise and falling edge to be detected
        .rise_out        (start_bitslip_pulse),     // output pulse of rising edge
        .fall_out        ()        //output pulse of falling edge
    );
    //Bitslip workaround        
    bitslip #(STROBE_PAT1,STROBE_PAT2)  
    bitslip_bank0(
        .clk                    (app_clk),
        .rst_in                 (sw_rst_app[24]),
        .bitslip_start          (start_bitslip_pulse),  //start signal for bitslipping
        .strobe_i               (data_to_fabric_strobe_rx_p), //ref data for synchronous
        //input data before bitslip
        .raw_data0_i            (data_to_fabric_rx_data0_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data1_i            (data_to_fabric_rx_data1_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data2_i            (data_to_fabric_rx_data2_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data3_i            (data_to_fabric_rx_data3_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data4_i            (data_to_fabric_rx_data4_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data5_i            (data_to_fabric_rx_data5_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data6_i            (data_to_fabric_rx_data6_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data7_i            (data_to_fabric_rx_data7_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data8_i            (data_to_fabric_rx_data8_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data9_i            (data_to_fabric_rx_data9_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data10_i           (data_to_fabric_rx_data10_p), // bitslipped [DESER_FACTOR-1:0] input 
        .raw_data11_i           (data_to_fabric_rx_data11_p), // bitslipped [DESER_FACTOR-1:0] input 
        //output data after bitslip
        .word_sync_data0_o      (bitslip_data_o[0]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data1_o      (bitslip_data_o[1]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data2_o      (bitslip_data_o[2]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data3_o      (bitslip_data_o[3]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data4_o      (bitslip_data_o[4]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data5_o      (bitslip_data_o[5]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data6_o      (bitslip_data_o[6]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data7_o      (bitslip_data_o[7]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data8_o      (bitslip_data_o[8]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data9_o      (bitslip_data_o[9]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data10_o     (bitslip_data_o[10]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_data11_o     (bitslip_data_o[11]),// [DESER_FACTOR-1:0] synchronized output
        .word_sync_strobe_o     (bitslip_strobe_o),
        
        //fifo
        .word_sync_valid_o      (bitslip_done)   // valid data handshake - 0 clk latency
    );     
    //Other control signals
    
    //Lanesync and word_align workaround
    genvar i;
    generate
        for(i=0;    i<NUM_OF_LANES;    i=i+1)
        begin : inst_generator
            lane_sync#(STROBE_PAT1,STROBE_PAT2) lane_sync_i(
        
                .clk                    (app_clk),   
                .rst_in                 (sw_rst_app[i]),
                .start_lane_align_i     (bitslip_done),  //start signal for lane alignment
        
        //input data before bitslip
                .raw_data_i             (bitslip_data_o[i]), // [DESER_FACTOR-1:0] input data 
                .raw_strobe_i           (bitslip_strobe_o), //ref data for synchronous
        //output data after alignment
                .lane_sync_data_o       (lane_sync_data_o[i]),// [DESER_FACTOR-1:0] synchronized output
                .lane_sync_strobe_o     (lane_sync_strobe_o[i]),
        
        //fifo
                .data_valid_o           (data_valid_o[i])   // valid data handshake - 0 clk latency
        );
           
			//Output data from the word_align module is one clock cycle ahead of word_valid
            word_align    #(
                    . STROBE_PAT1       (STROBE_PAT1),  //h80 00
                    . STROBE_PAT2       (STROBE_PAT2)  //h80 00
                 )word_align_i(
                    .deser_clk          (app_clk),
                    .reset              (sw_rst_app[i]),
                    .lane_sync_data     (lane_sync_data_o[i]),
                    .lane_sync_strobe   (lane_sync_strobe_o[i]),
                    .lane_valid         (data_valid_o[i]),
                    .word_sync_data     (word_align_data_o[i]),
                    .word_sync_strobe   (word_align_strobe_o[i]),
                    .word_valid         (word_valid_o[i])
            );            
        end
    endgenerate
    
    //IO Delay and Metastability check module instance
    genvar a;
        generate
            for(a=0; a<13; a=a+1)
            begin
				iodelay_n_metastab_chk Bank2_iod    (
					.app_clk                (app_clk), // metastability operation runs with app clk
					.rst_app                (sw_rst_app[a+12]),
					.riu_clk                (riu_clk),            //clock
					.rst_riu                (sw_rst_riu[1]),            //reset
					.ctrl_reg_16b           (ctrl_lane[a]),   //connect to 2 bytes out of 4 bytes of control register of AXI Reg map
					.cntvalue_out           (cntvalue_out_iod[a]),   //existing delay read from HSSIO IP
					.bsc_dly_rdy            (rx_dly_rdy_iod[a]),    //BITSLICE_CONTROL.DLY_RDY
					.bsc_vtc_rdy            (rx_vtc_rdy_iod[a]),    //BITSLICE_CONTROL.DLY_RDY
					.lane_data_i            (lane_data[a]),
					
					.status_reg_16b         (status_lane[a]),       //connect to 2 bytes out of 4 bytes of status register of AXI Reg map
					.rst_ctrl_reg           (rst_ctrl_lane[a]),     //reset the ctrl reg
					.cntvalue_in            (cntvalue_in_iod[a]),    //new computed delay
					.load                   (load_iod[a]),           //LOAD signal to HSSIO IP
					.ce                     (ce_iod[a]),             //CLOCK ENABLE signal to HSSIO IP
					.inc                    (inc_iod[a]),            //INC signal to HSSIO IP
					.rx_en_vtc              (rx_en_vtc_iod[a])       //RX_BITSLICE.EN_VTC
				);
            end
        endgenerate
    
    // RIU Interface IO Delay    
    riu_if_iodelay riu_io_i(
        .clk                    (riu_clk),
		.rst                    (sw_rst_riu[1]),
        .valid_i                (multi_riu_valid_bg),                    //valid_i = & bg_valid[3:0]
        .nib_i                  (ctrl_reg_nib),                      //upper/lower nibble specified
        .trig_re                (trig_riu_iodelay_re),        //trigger to denote new reg write has been done oncommand
        .bg_i                   (ctrl_reg_bg),
        .addr_i                 (ctrl_reg_addr),                     //address specified
        .riu_rd_data_bg0        (riu_rd_data_bg[0]),    //data from all bytegroups
        .riu_rd_data_bg1        (riu_rd_data_bg[1]),
        .riu_rd_data_bg2        (riu_rd_data_bg[2]),
        .riu_rd_data_bg3        (riu_rd_data_bg[3]),
        
        .riu_addr               (riu_addr_bg),           //addr to be connected to riu if
        .riu_nib_sel            (riu_nibble_sel_bg),        //nibble select to be connected to riu if
        .rd_data_o              (riu_if_rd_data),          //data read from riu
        .rd_done_o              (riu_if_rd_done),           //read from specified riu reg done
        .rst_ctrl_reg_riu       (rst_ctrl_reg_riu) 
    );
 
    //edge detection - trigger for IO Delay RIU Interface
    rise_fal_edge edge_det_e1(
        .clk_in          (riu_clk)  ,    //input clk
        .rst_in          (sw_rst_riu[1]) ,    //active high rst
        .signal_in       (trig_riu_iodelay),    //1b signal to which rise and falling edge to be detected
        .rise_out        (trig_riu_iodelay_re),     // output pulse of rising edge
        .fall_out        ()        //output pulse of falling edge
    );     

    fifo_generator_0_1 fifo_generator_i0 (
        .rst       (sw_rst_app[26]),                  // input wire srst 
        .wr_clk    (app_clk),                       // input wire wr_clk
        .rd_clk    (app_clk),                         // input wire rd_clk
        .din       (fifo_data_i),                     // input wire  [104 : 0] din
        .wr_en     (usr_fifo_wren),                      // input wire wr_en 
        .rd_en     (fifo_rd_en),                      // input wire rd_en
        .dout      (fifo_data_o),                   // output wire [104 : 0] dout
        .full      (),                                // output wire full
        .empty     (fifo_empty),                      // output wire empty
        .valid     (fifo_valid)                       // output wire valid
    );
      
    always@(posedge app_clk or posedge sw_rst_app[25])
    begin
        if(sw_rst_app[25])
            usr_fifo_wren   	<= 1'd0;
        else
            usr_fifo_wren   	<= |(word_valid_o);    
    end
    
    always @ (posedge app_clk or posedge sw_rst_app[25]) 
    begin
        if(sw_rst_app[25])
            valid_misalign 		<= 1'd0;
        else if(lane_valid_db)
            valid_misalign      <= 1'd1;
        else
            valid_misalign      <= valid_misalign;
    end

    always @(posedge app_clk or posedge sw_rst_app[25])
    begin
        if(sw_rst_app[25])
            hssio_fifo_rd_en    <= 1'b0; 
        else
            hssio_fifo_rd_en 	<= hssio_fifo_not_empty; 
    end 
    
    always @ (posedge app_clk or posedge sw_rst_app[25]) 
    begin
        if(sw_rst_app[25])
            start_bitslip     	<= 1'b0; 
        else if(!hssio_multi_intf_rdy_in_deser)
            start_bitslip   	<= 1'b0;
        else
            start_bitslip   	<= hssio_mult_fifo_rd_en;
    end
    //*********** debug wires for phy calibration signals************
    always @(posedge riu_clk)
    begin
        if(!hssio_intf_rdy_riu)
            hssio_dly_rdy_err    <= 1'b0;
        else if(hssio_intf_rdy_riu && !hssio_dly_rdy)
            hssio_dly_rdy_err    <= 1'b1;
        else
            hssio_dly_rdy_err    <= hssio_dly_rdy_err;
    end 
    
    always @(posedge riu_clk)
    begin
        if(!hssio_intf_rdy_riu)
            hssio_vtc_rdy_err    <= 1'b0;
        else if(hssio_intf_rdy_riu && !hssio_vtc_rdy)
            hssio_vtc_rdy_err    <= 1'b1;
        else
            hssio_vtc_rdy_err    <= hssio_vtc_rdy_err;
    end 
    
	assign  lane_rdy 				= data_valid_o[WREN_CNTL_LANE];      
    assign  lane_valid   			= ( |data_valid_o) && (!(&data_valid_o));
	
	assign  fifo_data_i     		= {word_align_strobe_o[STRB_CNTL_LANE],
									  word_align_data_o[11],  word_align_data_o[10],   word_align_data_o[9],    word_align_data_o[8],
									  word_align_data_o[7],   word_align_data_o[6],    word_align_data_o[5],    word_align_data_o[4],
									  word_align_data_o[3],   word_align_data_o[2],    word_align_data_o[1],    word_align_data_o[0]
									  }; //packing data of all lanes and strobe from 1 lane as all the strobes will be same
		
    assign  fifo_data_out           = fifo_data_o;

    assign  hssio_vtc_rdy_bsc[6]    = 1'b1;
    assign  hssio_dly_rdy_bsc[6]    = 1'b1;
    assign  riu_rd_data_bg[3]       = 16'hDEAD;
    assign  riu_valid_bg[3]         = 1'b1;
	
    assign  hssio_fifo_rd_en_out 	= hssio_fifo_rd_en;
    assign  hssio_vtc_rdy           = & hssio_vtc_rdy_bsc;
    assign  hssio_dly_rdy           = & hssio_dly_rdy_bsc;
    assign  hssio_en_vtc_bsc_in     = 1'b1;  
    assign  hssio_dly_rdy_err_db    = hssio_dly_rdy_err;
    assign  hssio_vtc_rdy_err_db    = hssio_vtc_rdy_err;  
    assign  hssio_fifo_not_empty    = ~(|hssio_fifo_empty[12:0]); //signal to show ip fifos are not empty
	
    //Packing for IO Delay
    assign  iod_rst_ctrl_reg1   	= rst_ctrl_lane[1]  || rst_ctrl_lane[0]; 
    assign  iod_rst_ctrl_reg2   	= rst_ctrl_lane[3]  || rst_ctrl_lane[2];
    assign  iod_rst_ctrl_reg3   	= rst_ctrl_lane[5]  || rst_ctrl_lane[4];
    assign  iod_rst_ctrl_reg4   	= rst_ctrl_lane[7]  || rst_ctrl_lane[6];
    assign  iod_rst_ctrl_reg5   	= rst_ctrl_lane[9]  || rst_ctrl_lane[8];
    assign  iod_rst_ctrl_reg6   	= rst_ctrl_lane[11] || rst_ctrl_lane[10];
    assign  iod_rst_ctrl_reg7   	= rst_ctrl_reg_riu;
    assign  iod_rst_ctrl_reg8   	= rst_ctrl_lane[12];
		
    assign  iod_status_reg1     	= {status_lane[1],    status_lane[0]}; 
    assign  iod_status_reg2     	= {status_lane[3],    status_lane[2]}; 
    assign  iod_status_reg3     	= {status_lane[5],    status_lane[4]};
    assign  iod_status_reg4     	= {status_lane[7],    status_lane[6]};
    assign  iod_status_reg5     	= {status_lane[9],    status_lane[8]};
    assign  iod_status_reg6     	= {status_lane[11],   status_lane[10]};
    assign  iod_status_reg7     	= {{16'b0},riu_if_rd_done,{6{1'b0}},riu_if_rd_data[8:0]};
    assign  iod_status_reg8     	= {{16'b0},{status_lane[12]}};
		
    assign  ctrl_lane [0]       	= iod_ctrl_reg1[15:0]; 
    assign  ctrl_lane [1]       	= iod_ctrl_reg1[31:16]; 
    assign  ctrl_lane [2]       	= iod_ctrl_reg2[15:0];
    assign  ctrl_lane [3]       	= iod_ctrl_reg2[31:16];
    assign  ctrl_lane [4]       	= iod_ctrl_reg3[15:0];
    assign  ctrl_lane [5]       	= iod_ctrl_reg3[31:16];
    assign  ctrl_lane [6]       	= iod_ctrl_reg4[15:0];
    assign  ctrl_lane [7]       	= iod_ctrl_reg4[31:16];
    assign  ctrl_lane [8]       	= iod_ctrl_reg5[15:0];
    assign  ctrl_lane [9]       	= iod_ctrl_reg5[31:16];
    assign  ctrl_lane [10]      	= iod_ctrl_reg6[15:0];
    assign  ctrl_lane [11]      	= iod_ctrl_reg6[31:16];
    assign  ctrl_lane [12]      	= iod_ctrl_reg8[15:0];
    assign  ctrl_reg_addr       	= iod_ctrl_reg7[5:0];
    assign  ctrl_reg_nib        	= iod_ctrl_reg7[6];
    assign  ctrl_reg_bg         	= iod_ctrl_reg7[8:7];
    assign  trig_riu_iodelay    	= iod_ctrl_reg7[15];
		
    //Lane-sync Assignmenmts	
    assign  lane_data[0]        	= data_to_fabric_rx_data0_p;                                 
    assign  lane_data[1]        	= data_to_fabric_rx_data1_p; 
    assign  lane_data[2]        	= data_to_fabric_rx_data2_p; 
    assign  lane_data[3]        	= data_to_fabric_rx_data3_p; 
    assign  lane_data[4]        	= data_to_fabric_rx_data4_p; 
    assign  lane_data[5]        	= data_to_fabric_rx_data5_p; 
    assign  lane_data[6]        	= data_to_fabric_rx_data6_p; 
    assign  lane_data[7]        	= data_to_fabric_rx_data7_p; 
    assign  lane_data[8]        	= data_to_fabric_rx_data8_p; 
    assign  lane_data[9]        	= data_to_fabric_rx_data9_p; 
    assign  lane_data[10]       	= data_to_fabric_rx_data10_p;
    assign  lane_data[11]       	= data_to_fabric_rx_data11_p;
    assign  lane_data[12]       	= data_to_fabric_strobe_rx_p;
		
    //vtc_rdy	
    assign  rx_vtc_rdy_iod[0]   	= hssio_vtc_rdy_bsc[2];
    assign  rx_vtc_rdy_iod[1]   	= hssio_vtc_rdy_bsc[5];
    assign  rx_vtc_rdy_iod[2]   	= hssio_vtc_rdy_bsc[5];
    assign  rx_vtc_rdy_iod[3]   	= hssio_vtc_rdy_bsc[5];
    assign  rx_vtc_rdy_iod[4]   	= hssio_vtc_rdy_bsc[4];
    assign  rx_vtc_rdy_iod[5]   	= hssio_vtc_rdy_bsc[0];
    assign  rx_vtc_rdy_iod[6]   	= hssio_vtc_rdy_bsc[2];
    assign  rx_vtc_rdy_iod[7]   	= hssio_vtc_rdy_bsc[2];
    assign  rx_vtc_rdy_iod[8]   	= hssio_vtc_rdy_bsc[3];
    assign  rx_vtc_rdy_iod[9]   	= hssio_vtc_rdy_bsc[1];
    assign  rx_vtc_rdy_iod[10]  	= hssio_vtc_rdy_bsc[3];
    assign  rx_vtc_rdy_iod[11]  	= hssio_vtc_rdy_bsc[0];
    assign  rx_vtc_rdy_iod[12]  	= hssio_vtc_rdy_bsc[4];
		
    //dly_rdy	
    assign  rx_dly_rdy_iod[0]   	= hssio_dly_rdy_bsc[2];
    assign  rx_dly_rdy_iod[1]   	= hssio_dly_rdy_bsc[5];
    assign  rx_dly_rdy_iod[2]   	= hssio_dly_rdy_bsc[5];
    assign  rx_dly_rdy_iod[3]   	= hssio_dly_rdy_bsc[5];
    assign  rx_dly_rdy_iod[4]   	= hssio_dly_rdy_bsc[4];
    assign  rx_dly_rdy_iod[5]   	= hssio_dly_rdy_bsc[0];
    assign  rx_dly_rdy_iod[6]   	= hssio_dly_rdy_bsc[2];
    assign  rx_dly_rdy_iod[7]   	= hssio_dly_rdy_bsc[2];
    assign  rx_dly_rdy_iod[8]   	= hssio_dly_rdy_bsc[3];
    assign  rx_dly_rdy_iod[9]   	= hssio_dly_rdy_bsc[1];
    assign  rx_dly_rdy_iod[10]  	= hssio_dly_rdy_bsc[3];
    assign  rx_dly_rdy_iod[11]  	= hssio_dly_rdy_bsc[0];
    assign  rx_dly_rdy_iod[12]  	= hssio_dly_rdy_bsc[4];    
		
    //Synchronisation blocks                
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i0   (
       .src_data      (hssio_en_vtc_bsc_in), //clock domain: asynchronous: 1 always
       .dest_clk      (riu_clk), 
       .dest_data     (hssio_en_vtc_bsc_in_riu)  //rst to IP is done through pll_locked sync with riu_clk
    );  
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i1   (
        .src_data     (lane_valid), 
        .dest_clk     (app_clk),
        .dest_data    (lane_valid_db)
    );
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i2   (
        .src_data     (hssio_intf_rdy), 
        .dest_clk     (riu_clk),
        .dest_data    (hssio_intf_rdy_riu)
    );

    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i3   (
        .src_data     (hssio_multi_intf_rdy_in), 
        .dest_clk     (app_clk),
        .dest_data    (hssio_multi_intf_rdy_in_deser)
    );                                           
 
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i4   (
		.src_data  	  (&riu_valid_bg),        //Clock_domain: riu_clk
		.dest_clk  	  (riu_clk),              //riu clk
		.dest_data 	  (multi_riu_valid_bg)
    );
    

       
endmodule