`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Soliton technologies
// Engineer: 
// 
// Create Date: 08/01/2017 11:18:16 AM
// Design Name: LRX
// Module Name: LRX
// Project Name: WBLVDS
// Target Devices: TSW14Dl3200
// Tool Versions: 2017.1
// Description: 
//      This IP contains the 4 HSSIO IP instances. This acts as the main LVDS Rx Interface containing 48 lanes and 4 strobes. 
//          - Pin location constraints to be used as in LRX.xdc packed with this IP.
// Dependencies: LRX_reg_map,rx_channel_0,rx_channel_1,rx_channel_2,rx_channel_3
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:

//////////////////////////////////////////////////////////////////////////////////


module LRX   
    #(parameter     SW_RST_RIU_FANOUT   =   16'd8,
      parameter     SW_RST_APP_FANOUT   =   16'd120,
      parameter     STROBE_PAT1     	=   8'h00,  
      parameter     STROBE_PAT2     	=   8'h80,  
      parameter     ADC_RESOLUTION     	=   'd12  
        )
    (
	 //Clock and Reset Signals
    input                           riu_clk,    	//200Mhz free running clock
	output                          app_clk,        //clock from the PLL of any 1 of the 4 HSSIO Ips
	
    input   [SW_RST_RIU_FANOUT-1:0] sw_rst_riu,   	// sw reset w.r.t riu clk domain
    input   [SW_RST_APP_FANOUT-1:0] sw_rst_app,		// sw reset w.r.t app clk domain
	
	//Signals from/to ADC (FPGA pinouts)
    input   [3:0]      	            rx_clk_p,       //Received LVDS clock
    input   [3:0]      	            rx_clk_n,
    input   [47:0]     	            rx_data_p,      //Received LVDS Data
    input   [47:0]     	            rx_data_n,
    input   [3:0]                   strobe_rx_p,    //Received LVDS Strobe
    input   [3:0]                   strobe_rx_n,

	output                          rx_sync,        //rx_sync signal - denotes that the Rx is synchronised and ready to receive the data  
                                                    //synchronisation of RX is done by sending a constant pattern on all the lanes. Pattern in hardcoded in this FW.												
	//Signals to FPGA fabric - Data 

    output  [7:0]                   busA_strb,   // Strobe from busA
                                    busB_strb,   // Strobe from busB
                                    busC_strb,   // Strobe from busC
                                    busD_strb,   // Strobe from busD
									
    output                          busA_valid,  // Valid from busA
                                    busB_valid,  // Valid from busB
                                    busC_valid,  // Valid from busC
                                    busD_valid,  // Valid from busD
	

	output	[ADC_RESOLUTION - 1: 0]	busA_sample0,	//12bit adc output on bus A 
	output	[ADC_RESOLUTION - 1: 0]	busA_sample1,   //12bit adc output on bus A
	output	[ADC_RESOLUTION - 1: 0]	busA_sample2,   //12bit adc output on bus A
	output	[ADC_RESOLUTION - 1: 0]	busA_sample3,   //12bit adc output on bus A
	output	[ADC_RESOLUTION - 1: 0]	busA_sample4,   //12bit adc output on bus A
	output	[ADC_RESOLUTION - 1: 0]	busA_sample5,   //12bit adc output on bus A
	output	[ADC_RESOLUTION - 1: 0]	busA_sample6,   //12bit adc output on bus A
	output	[ADC_RESOLUTION - 1: 0]	busA_sample7,   //12bit adc output on bus A
                                                
	output	[ADC_RESOLUTION - 1: 0]	busB_sample0,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample1,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample2,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample3,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample4,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample5,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample6,   //12bit adc output on bus B
	output	[ADC_RESOLUTION - 1: 0]	busB_sample7,   //12bit adc output on bus B
                                                
	output	[ADC_RESOLUTION - 1: 0]	busC_sample0,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample1,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample2,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample3,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample4,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample5,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample6,   //12bit adc output on bus C
	output	[ADC_RESOLUTION - 1: 0]	busC_sample7,   //12bit adc output on bus C
                                                
	output	[ADC_RESOLUTION - 1: 0]	busD_sample0,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample1,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample2,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample3,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample4,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample5,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample6,   //12bit adc output on bus D
	output	[ADC_RESOLUTION - 1: 0]	busD_sample7,   //12bit adc output on bus D
	
	//axi reg map ports
    input                           s_axi_clk,                                                            
    input                           s_axi_rst_n, 
                               
    input   [31:0]                  s_axi_araddr,                     
    input                           s_axi_arvalid,                          
    output                          s_axi_arready,                          
    
    input   [31:0]                  s_axi_awaddr,                     
    input                           s_axi_awvalid,                          
    output                          s_axi_awready,                          
    
    input                           s_axi_rready,          
    output                          s_axi_rvalid,       
    output  [31:0]                  s_axi_rdata,           
    output  [1:0]                   s_axi_rresp,             
   
    input                           s_axi_wvalid,          
    input   [31:0]                  s_axi_wdata,           
    output                          s_axi_wready,                           
    input   [3:0]                   s_axi_wstrb,                        
    
    input                           s_axi_bready,                             
    output                          s_axi_bvalid,                                                   
    output  [1:0]                   s_axi_bresp, 
    
    //bus A IOD config reg map ports
    input   [31:0]                  busA_s_axi_araddr,                     
    input                           busA_s_axi_arvalid,                          
    output                          busA_s_axi_arready,                          
                                
    input   [31:0]                  busA_s_axi_awaddr,                     
    input                           busA_s_axi_awvalid,                          
    output                          busA_s_axi_awready,                          
                                  
    input                           busA_s_axi_rready,      
    output                          busA_s_axi_rvalid,      
    output  [31:0]                  busA_s_axi_rdata,       
    output  [1:0]                   busA_s_axi_rresp,         
                                 
    input                           busA_s_axi_wvalid,      
    input   [31:0]                  busA_s_axi_wdata,       
    output                          busA_s_axi_wready,            
    input   [3:0]                   busA_s_axi_wstrb,         
                                 
    input                           busA_s_axi_bready,              
    output                          busA_s_axi_bvalid,                                    
    output  [1:0]                   busA_s_axi_bresp,  
    
    //bus B IOD config reg map ports
    input   [31:0]                  busB_s_axi_araddr,      
    input                           busB_s_axi_arvalid,           
    output                          busB_s_axi_arready,           
                                 
    input   [31:0]                  busB_s_axi_awaddr,      
    input                           busB_s_axi_awvalid,           
    output                          busB_s_axi_awready,           
                                 
    input                           busB_s_axi_rready,      
    output                          busB_s_axi_rvalid,      
    output  [31:0]                  busB_s_axi_rdata,       
    output  [1:0]                   busB_s_axi_rresp,         
                                 
    input                           busB_s_axi_wvalid,      
    input   [31:0]                  busB_s_axi_wdata,       
    output                          busB_s_axi_wready,            
    input   [3:0]                   busB_s_axi_wstrb,         
                                 
    input                           busB_s_axi_bready,              
    output                          busB_s_axi_bvalid,                                    
    output  [1:0]                   busB_s_axi_bresp,  
        
    //bus C IOD config reg map ports
    input   [31:0]                  busC_s_axi_araddr,      
    input                           busC_s_axi_arvalid,           
    output                          busC_s_axi_arready,           
                                   
    input   [31:0]                  busC_s_axi_awaddr,      
    input                           busC_s_axi_awvalid,           
    output                          busC_s_axi_awready,           
                                   
    input                           busC_s_axi_rready,      
    output                          busC_s_axi_rvalid,      
    output  [31:0]                  busC_s_axi_rdata,       
    output  [1:0]                   busC_s_axi_rresp,         
                                  
    input                           busC_s_axi_wvalid,      
    input   [31:0]                  busC_s_axi_wdata,       
    output                          busC_s_axi_wready,            
    input   [3:0]                   busC_s_axi_wstrb,         
                                   
    input                           busC_s_axi_bready,                             
    output                          busC_s_axi_bvalid,                                                   
    output  [1:0]                   busC_s_axi_bresp,  
            
    //bus D IOD config reg map ports
    input   [31:0]                  busD_s_axi_araddr,                     
    input                           busD_s_axi_arvalid,                          
    output                          busD_s_axi_arready,                          
                                  
    input   [31:0]                  busD_s_axi_awaddr,                     
    input                           busD_s_axi_awvalid,                          
    output                          busD_s_axi_awready,                          
                                
    input                           busD_s_axi_rready,      
    output                          busD_s_axi_rvalid,      
    output  [31:0]                  busD_s_axi_rdata,       
    output  [1:0]                   busD_s_axi_rresp,       
                              
    input                           busD_s_axi_wvalid,      
    input   [31:0]                  busD_s_axi_wdata,       
    output                          busD_s_axi_wready,          
    input   [3:0]                   busD_s_axi_wstrb,       
                                  
    input                           busD_s_axi_bready,                             
    output                          busD_s_axi_bvalid,                                                   
    output  [1:0]                   busD_s_axi_bresp,  

	//status signals 
    output                          rx_rst_done    		//denotes rx is out of reset        
    );

//------------------- general reg and wire declaration--------------------
    localparam	    LANES_PER_BANK       = 4'd12;
    localparam	    NUM_OF_BANKS         = 3'd4;
    localparam	    NUM_OF_LANES         = NUM_OF_BANKS * LANES_PER_BANK;
    localparam	    CNTL_BANK_FOR_SYNC   = 1'd0;

//------------------- RX IPs declarations --------------------------
                 
    wire    [3:0]   	rx_intf_rdy,                //Interface ready
						rx_intf_rdy_riu,            //Interface ready synced with riu_clk
						rx_pll0_locked,             //PLL0 locked of 4 HSSIO IPs
						rx_pll0_locked_riu;         //PLL0 locked of 4 HSSIO IPs synced to riu_clk
						
    wire            	pll_clk_rx0;                //clock from IP0 - to be used as deser_clk, app_clk
		
    wire            	rx_multibank_pll0_locked_riu,   // rx_multibank_pll0_locked synced to riu_clk
						rx_multibank_intf_rdy_riu;      //rx_multibank_intf_rdy synced to riu_clk
                        
    wire    			rx_multibank_pll0_locked,   //denotes that all 4 banks PLL have got locked
						rx_multibank_intf_rdy;      //denotes that all 4 banks interfaces are ready
            
// ------------------ User fifo ----------------------
    
    wire    [103:0] 	fifo_out_rx0, //data from HSSIO IP output FIFOs 
						fifo_out_rx1,  
						fifo_out_rx2,  
						fifo_out_rx3;
		
    wire    [3:0]   	fifo_empty_rx,  //empty for 4 HSSIO IP FIFOs
					    fifo_valid_rx;  //valid for 4 HSSIO IP FIFOs
							
    wire  				fifo_rd_en;

	wire	[7:0]		busA_fifo_strb_out,
						busB_fifo_strb_out,
						busC_fifo_strb_out,
						busD_fifo_strb_out;

	wire    [95:0]      busA_fifo_data_out,   // Data from 12 lanes on IP0 
                        busB_fifo_data_out,   // Data from 12 lanes on IP1 
                        busC_fifo_data_out,   // Data from 12 lanes on IP2  
                        busD_fifo_data_out;   // Data from 12 lanes on IP3 	
						
	wire 				busA_fifo_valid_out, 
	                    busB_fifo_valid_out, 
	                    busC_fifo_valid_out, 
	                    busD_fifo_valid_out;                
                                                
 //reg map signals
    wire    [31:0]  	status_reg1_in,
						status_reg2_in,
						ctrl_reg1_out,
						ctrl_reg2_out;
						
    wire            	rx_sync_polarity,   //0- active low, 1-active high
						rx_start_sync,
						rx_start_sync_app,
						hssio_mult_fifo_rd_en; 
				
    wire    [3:0]   	lane_rdy_riu,
						hssio_fifo_rd_en,
						lane_rdy;
		
    reg             	rx_sync_riu;
    reg             	rx_sync_app;
    wire        		lane_rdy_riu_ctrl,
						hssio_fifo_rd_en_ctrl;
	wire 	[3:0]  		hssio_fifo_rd_en_app;

									
	//support demux by 1 mode,bank_in_active signal should be handled 
	//4'hF - LDEMUX1 ,  4'h0 - LDEMUX0	             
    wire   [3:0]        bank_in_active; //Denotes which are all banks out of the 4 are active
	
    wire 	[3:0]  		bank_in_active_riu,
						bank_in_active_app;
			
	//IODelay signals
    wire    [3:0][31:0] iod_ctrl_reg1,
                        iod_ctrl_reg2,
                        iod_ctrl_reg3,
                        iod_ctrl_reg4,
                        iod_ctrl_reg5,
                        iod_ctrl_reg6,
                        iod_ctrl_reg7,
                        iod_ctrl_reg8;
                        
    wire    [3:0]       iod_rst_ctrl_reg1,
                        iod_rst_ctrl_reg2,
                        iod_rst_ctrl_reg3,
                        iod_rst_ctrl_reg4,
                        iod_rst_ctrl_reg5,
                        iod_rst_ctrl_reg6,
                        iod_rst_ctrl_reg7,
                        iod_rst_ctrl_reg8;
                       
    wire    [3:0][31:0] iod_status_reg1,
                        iod_status_reg2,
                        iod_status_reg3,
                        iod_status_reg4,
                        iod_status_reg5,
                        iod_status_reg6,
                        iod_status_reg7,
                        iod_status_reg8;     
        
     //AXI REG MAP   
    LRX_reg_map LRX_reg_map_i (
        .clk                        (s_axi_clk),                      // input wire clk
        .reset_n                    (s_axi_rst_n),              // input wire reset_n
        .s_axi_araddr               (s_axi_araddr),     // input wire [31 : 0] s_axi_araddr
        .s_axi_arvalid              (s_axi_arvalid),    // input wire s_axi_arvalid
        .s_axi_arready              (s_axi_arready),    // output wire s_axi_arready
        .s_axi_awaddr               (s_axi_awaddr),     // input wire [31 : 0] s_axi_awaddr
        .s_axi_awvalid              (s_axi_awvalid),    // input wire s_axi_awvalid
        .s_axi_awready              (s_axi_awready),    // output wire s_axi_awready
        .s_axi_rready               (s_axi_rready),     // input wire s_axi_rready
        .s_axi_rvalid               (s_axi_rvalid),     // output wire s_axi_rvalid
        .s_axi_rdata                (s_axi_rdata),      // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp                (s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
        .s_axi_wvalid               (s_axi_wvalid),     // input wire s_axi_wvalid
        .s_axi_wdata                (s_axi_wdata),      // input wire [31 : 0] s_axi_wdata
        .s_axi_wready               (s_axi_wready),     // output wire s_axi_wready
        .s_axi_wstrb                (s_axi_wstrb),      // input wire [3 : 0] s_axi_wstrb
        .s_axi_bready               (s_axi_bready),     // input wire s_axi_bready
        .s_axi_bvalid               (s_axi_bvalid),     // output wire s_axi_bvalid
        .s_axi_bresp                (s_axi_bresp),      // output wire [1 : 0] s_axi_bresp
        .ctrl_reg1                  (ctrl_reg1_out),    // output wire [31 : 0] ctrl_reg1
        .ctrl_reg2                  (ctrl_reg2_out),    // output wire [31 : 0] ctrl_reg2
        .ctrl_reg3                  (),    // output wire [31 : 0] ctrl_reg3
        .ctrl_reg4                  (),                 // output wire [31 : 0] ctrl_reg4
        .ctrl_reg5                  (),                 // output wire [31 : 0] ctrl_reg5
        .ctrl_reg6                  (),                 // output wire [31 : 0] ctrl_reg6
        .ctrl_reg7                  (),                 // output wire [31 : 0] ctrl_reg7
        .ctrl_reg8                  (),                 // output wire [31 : 0] ctrl_reg8
        .rst_ctrl_reg1              (),                 // input wire rst_ctrl_reg1
        .rst_ctrl_reg2              (),                 // input wire rst_ctrl_reg2
        .rst_ctrl_reg3              (),                 // input wire rst_ctrl_reg3
        .rst_ctrl_reg4              (),                 // input wire rst_ctrl_reg4
        .rst_ctrl_reg5              (),                 // input wire rst_ctrl_reg5
        .rst_ctrl_reg6              (),                 // input wire rst_ctrl_reg6
        .rst_ctrl_reg7              (),                 // input wire rst_ctrl_reg7
        .rst_ctrl_reg8              (),                 // input wire rst_ctrl_reg8
        .status_reg1                (status_reg1_in),   // input wire [31 : 0] status_reg1
        .status_reg2                (status_reg2_in),   // input wire [31 : 0] status_reg2
        .status_reg3                (),                 // input wire [31 : 0] status_reg3
        .status_reg4                (),                 // input wire [31 : 0] status_reg4
        .status_reg5                (),                 // input wire [31 : 0] status_reg5
        .status_reg6                (),                 // input wire [31 : 0] status_reg6
        .status_reg7                (),                 // input wire [31 : 0] status_reg7
        .status_reg8                ()                  // input wire [31 : 0] status_reg8
    );
    
    Bank0_reg_map_iod busA_reg_map_iod_i (
        .clk                        (s_axi_clk),                      // input wire clk
        .reset_n                    (s_axi_rst_n),              // input wire reset_n
        .s_axi_araddr               (busA_s_axi_araddr),      // input wire [31 : 0] s_axi_araddr
        .s_axi_arvalid              (busA_s_axi_arvalid),     // input wire s_axi_arvalid
        .s_axi_arready              (busA_s_axi_arready),     // output wire s_axi_arready
        .s_axi_awaddr               (busA_s_axi_awaddr),      // input wire [31 : 0] s_axi_awaddr
        .s_axi_awvalid              (busA_s_axi_awvalid),     // input wire s_axi_awvalid
        .s_axi_awready              (busA_s_axi_awready),     // output wire s_axi_awready
        .s_axi_rready               (busA_s_axi_rready),      // input wire s_axi_rready
        .s_axi_rvalid               (busA_s_axi_rvalid),      // output wire s_axi_rvalid
        .s_axi_rdata                (busA_s_axi_rdata),       // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp                (busA_s_axi_rresp),       // output wire [1 : 0] s_axi_rresp
        .s_axi_wvalid               (busA_s_axi_wvalid),      // input wire s_axi_wvalid
        .s_axi_wdata                (busA_s_axi_wdata),       // input wire [31 : 0] s_axi_wdata
        .s_axi_wready               (busA_s_axi_wready),      // output wire s_axi_wready
        .s_axi_wstrb                (busA_s_axi_wstrb),       // input wire [3 : 0] s_axi_wstrb
        .s_axi_bready               (busA_s_axi_bready),      // input wire s_axi_bready
        .s_axi_bvalid               (busA_s_axi_bvalid),      // output wire s_axi_bvalid
        .s_axi_bresp                (busA_s_axi_bresp),       // output wire [1 : 0] s_axi_bresp
        .ctrl_reg1                  (iod_ctrl_reg1[0]),         // output wire [31 : 0] ctrl_reg1
        .ctrl_reg2                  (iod_ctrl_reg2[0]),         // output wire [31 : 0] ctrl_reg2
        .ctrl_reg3                  (iod_ctrl_reg3[0]),         // output wire [31 : 0] ctrl_reg3
        .ctrl_reg4                  (iod_ctrl_reg4[0]),         // output wire [31 : 0] ctrl_reg4
        .ctrl_reg5                  (iod_ctrl_reg5[0]),         // output wire [31 : 0] ctrl_reg5
        .ctrl_reg6                  (iod_ctrl_reg6[0]),         // output wire [31 : 0] ctrl_reg6
        .ctrl_reg7                  (iod_ctrl_reg7[0]),         // output wire [31 : 0] ctrl_reg7
        .ctrl_reg8                  (iod_ctrl_reg8[0]),         // output wire [31 : 0] ctrl_reg8
        .rst_ctrl_reg1              (iod_rst_ctrl_reg1[0]),                     // input wire rst_ctrl_reg1
        .rst_ctrl_reg2              (iod_rst_ctrl_reg2[0]),                     // input wire rst_ctrl_reg2
        .rst_ctrl_reg3              (iod_rst_ctrl_reg3[0]),                     // input wire rst_ctrl_reg3
        .rst_ctrl_reg4              (iod_rst_ctrl_reg4[0]),                     // input wire rst_ctrl_reg4
        .rst_ctrl_reg5              (iod_rst_ctrl_reg5[0]),                     // input wire rst_ctrl_reg5
        .rst_ctrl_reg6              (iod_rst_ctrl_reg6[0]),                     // input wire rst_ctrl_reg6
        .rst_ctrl_reg7              (iod_rst_ctrl_reg7[0]),                     // input wire rst_ctrl_reg7
        .rst_ctrl_reg8              (iod_rst_ctrl_reg8[0]),                     // input wire rst_ctrl_reg8
        .status_reg1                (iod_status_reg1[0]),       // input wire [31 : 0] status_reg1
        .status_reg2                (iod_status_reg2[0]),       // input wire [31 : 0] status_reg2
        .status_reg3                (iod_status_reg3[0]),       // input wire [31 : 0] status_reg3
        .status_reg4                (iod_status_reg4[0]),       // input wire [31 : 0] status_reg4
        .status_reg5                (iod_status_reg5[0]),       // input wire [31 : 0] status_reg5
        .status_reg6                (iod_status_reg6[0]),       // input wire [31 : 0] status_reg6
        .status_reg7                (iod_status_reg7[0]),       // input wire [31 : 0] status_reg7
        .status_reg8                (iod_status_reg8[0])        // input wire [31 : 0] status_reg8
    ); 
    
    Bank0_reg_map_iod busB_reg_map_iod_i (
        .clk                        (s_axi_clk),                      // input wire clk
        .reset_n                    (s_axi_rst_n),              // input wire reset_n
        .s_axi_araddr               (busB_s_axi_araddr),      // input wire [31 : 0] s_axi_araddr
        .s_axi_arvalid              (busB_s_axi_arvalid),     // input wire s_axi_arvalid
        .s_axi_arready              (busB_s_axi_arready),     // output wire s_axi_arready
        .s_axi_awaddr               (busB_s_axi_awaddr),      // input wire [31 : 0] s_axi_awaddr
        .s_axi_awvalid              (busB_s_axi_awvalid),     // input wire s_axi_awvalid
        .s_axi_awready              (busB_s_axi_awready),     // output wire s_axi_awready
        .s_axi_rready               (busB_s_axi_rready),      // input wire s_axi_rready
        .s_axi_rvalid               (busB_s_axi_rvalid),      // output wire s_axi_rvalid
        .s_axi_rdata                (busB_s_axi_rdata),       // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp                (busB_s_axi_rresp),       // output wire [1 : 0] s_axi_rresp
        .s_axi_wvalid               (busB_s_axi_wvalid),      // input wire s_axi_wvalid
        .s_axi_wdata                (busB_s_axi_wdata),       // input wire [31 : 0] s_axi_wdata
        .s_axi_wready               (busB_s_axi_wready),      // output wire s_axi_wready
        .s_axi_wstrb                (busB_s_axi_wstrb),       // input wire [3 : 0] s_axi_wstrb
        .s_axi_bready               (busB_s_axi_bready),      // input wire s_axi_bready
        .s_axi_bvalid               (busB_s_axi_bvalid),      // output wire s_axi_bvalid
        .s_axi_bresp                (busB_s_axi_bresp),       // output wire [1 : 0] s_axi_bresp
        .ctrl_reg1                  (iod_ctrl_reg1[1]),         // output wire [31 : 0] ctrl_reg1
        .ctrl_reg2                  (iod_ctrl_reg2[1]),         // output wire [31 : 0] ctrl_reg2
        .ctrl_reg3                  (iod_ctrl_reg3[1]),         // output wire [31 : 0] ctrl_reg3
        .ctrl_reg4                  (iod_ctrl_reg4[1]),         // output wire [31 : 0] ctrl_reg4
        .ctrl_reg5                  (iod_ctrl_reg5[1]),         // output wire [31 : 0] ctrl_reg5
        .ctrl_reg6                  (iod_ctrl_reg6[1]),         // output wire [31 : 0] ctrl_reg6
        .ctrl_reg7                  (iod_ctrl_reg7[1]),         // output wire [31 : 0] ctrl_reg7
        .ctrl_reg8                  (iod_ctrl_reg8[1]),         // output wire [31 : 0] ctrl_reg8
        .rst_ctrl_reg1              (iod_rst_ctrl_reg1[1]),                     // input wire rst_ctrl_reg1
        .rst_ctrl_reg2              (iod_rst_ctrl_reg2[1]),                     // input wire rst_ctrl_reg2
        .rst_ctrl_reg3              (iod_rst_ctrl_reg3[1]),                     // input wire rst_ctrl_reg3
        .rst_ctrl_reg4              (iod_rst_ctrl_reg4[1]),                     // input wire rst_ctrl_reg4
        .rst_ctrl_reg5              (iod_rst_ctrl_reg5[1]),                     // input wire rst_ctrl_reg5
        .rst_ctrl_reg6              (iod_rst_ctrl_reg6[1]),                     // input wire rst_ctrl_reg6
        .rst_ctrl_reg7              (iod_rst_ctrl_reg7[1]),                     // input wire rst_ctrl_reg7
        .rst_ctrl_reg8              (iod_rst_ctrl_reg8[1]),                     // input wire rst_ctrl_reg8
        .status_reg1                (iod_status_reg1[1]),       // input wire [31 : 0] status_reg1
        .status_reg2                (iod_status_reg2[1]),       // input wire [31 : 0] status_reg2
        .status_reg3                (iod_status_reg3[1]),       // input wire [31 : 0] status_reg3
        .status_reg4                (iod_status_reg4[1]),       // input wire [31 : 0] status_reg4
        .status_reg5                (iod_status_reg5[1]),       // input wire [31 : 0] status_reg5
        .status_reg6                (iod_status_reg6[1]),       // input wire [31 : 0] status_reg6
        .status_reg7                (iod_status_reg7[1]),       // input wire [31 : 0] status_reg7
        .status_reg8                (iod_status_reg8[1])        // input wire [31 : 0] status_reg8
    ); 
        
    Bank0_reg_map_iod busC_reg_map_iod_i (
        .clk                        (s_axi_clk),                      // input wire clk
        .reset_n                    (s_axi_rst_n),              // input wire reset_n
        .s_axi_araddr               (busC_s_axi_araddr),      // input wire [31 : 0] s_axi_araddr
        .s_axi_arvalid              (busC_s_axi_arvalid),     // input wire s_axi_arvalid
        .s_axi_arready              (busC_s_axi_arready),     // output wire s_axi_arready
        .s_axi_awaddr               (busC_s_axi_awaddr),      // input wire [31 : 0] s_axi_awaddr
        .s_axi_awvalid              (busC_s_axi_awvalid),     // input wire s_axi_awvalid
        .s_axi_awready              (busC_s_axi_awready),     // output wire s_axi_awready
        .s_axi_rready               (busC_s_axi_rready),      // input wire s_axi_rready
        .s_axi_rvalid               (busC_s_axi_rvalid),      // output wire s_axi_rvalid
        .s_axi_rdata                (busC_s_axi_rdata),       // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp                (busC_s_axi_rresp),       // output wire [1 : 0] s_axi_rresp
        .s_axi_wvalid               (busC_s_axi_wvalid),      // input wire s_axi_wvalid
        .s_axi_wdata                (busC_s_axi_wdata),       // input wire [31 : 0] s_axi_wdata
        .s_axi_wready               (busC_s_axi_wready),      // output wire s_axi_wready
        .s_axi_wstrb                (busC_s_axi_wstrb),       // input wire [3 : 0] s_axi_wstrb
        .s_axi_bready               (busC_s_axi_bready),      // input wire s_axi_bready
        .s_axi_bvalid               (busC_s_axi_bvalid),      // output wire s_axi_bvalid
        .s_axi_bresp                (busC_s_axi_bresp),       // output wire [1 : 0] s_axi_bresp
        .ctrl_reg1                  (iod_ctrl_reg1[2]),         // output wire [31 : 0] ctrl_reg1
        .ctrl_reg2                  (iod_ctrl_reg2[2]),         // output wire [31 : 0] ctrl_reg2
        .ctrl_reg3                  (iod_ctrl_reg3[2]),         // output wire [31 : 0] ctrl_reg3
        .ctrl_reg4                  (iod_ctrl_reg4[2]),         // output wire [31 : 0] ctrl_reg4
        .ctrl_reg5                  (iod_ctrl_reg5[2]),         // output wire [31 : 0] ctrl_reg5
        .ctrl_reg6                  (iod_ctrl_reg6[2]),         // output wire [31 : 0] ctrl_reg6
        .ctrl_reg7                  (iod_ctrl_reg7[2]),         // output wire [31 : 0] ctrl_reg7
        .ctrl_reg8                  (iod_ctrl_reg8[2]),         // output wire [31 : 0] ctrl_reg8
        .rst_ctrl_reg1              (iod_rst_ctrl_reg1[2]),                     // input wire rst_ctrl_reg1
        .rst_ctrl_reg2              (iod_rst_ctrl_reg2[2]),                     // input wire rst_ctrl_reg2
        .rst_ctrl_reg3              (iod_rst_ctrl_reg3[2]),                     // input wire rst_ctrl_reg3
        .rst_ctrl_reg4              (iod_rst_ctrl_reg4[2]),                     // input wire rst_ctrl_reg4
        .rst_ctrl_reg5              (iod_rst_ctrl_reg5[2]),                     // input wire rst_ctrl_reg5
        .rst_ctrl_reg6              (iod_rst_ctrl_reg6[2]),                     // input wire rst_ctrl_reg6
        .rst_ctrl_reg7              (iod_rst_ctrl_reg7[2]),                     // input wire rst_ctrl_reg7
        .rst_ctrl_reg8              (iod_rst_ctrl_reg8[2]),                     // input wire rst_ctrl_reg8
        .status_reg1                (iod_status_reg1[2]),       // input wire [31 : 0] status_reg1
        .status_reg2                (iod_status_reg2[2]),       // input wire [31 : 0] status_reg2
        .status_reg3                (iod_status_reg3[2]),       // input wire [31 : 0] status_reg3
        .status_reg4                (iod_status_reg4[2]),       // input wire [31 : 0] status_reg4
        .status_reg5                (iod_status_reg5[2]),       // input wire [31 : 0] status_reg5
        .status_reg6                (iod_status_reg6[2]),       // input wire [31 : 0] status_reg6
        .status_reg7                (iod_status_reg7[2]),       // input wire [31 : 0] status_reg7
        .status_reg8                (iod_status_reg8[2])        // input wire [31 : 0] status_reg8
    ); 
            
    Bank0_reg_map_iod busD_reg_map_iod_i (
        .clk                        (s_axi_clk),                      // input wire clk
        .reset_n                    (s_axi_rst_n),              // input wire reset_n
        .s_axi_araddr               (busD_s_axi_araddr),      // input wire [31 : 0] s_axi_araddr
        .s_axi_arvalid              (busD_s_axi_arvalid),     // input wire s_axi_arvalid
        .s_axi_arready              (busD_s_axi_arready),     // output wire s_axi_arready
        .s_axi_awaddr               (busD_s_axi_awaddr),      // input wire [31 : 0] s_axi_awaddr
        .s_axi_awvalid              (busD_s_axi_awvalid),     // input wire s_axi_awvalid
        .s_axi_awready              (busD_s_axi_awready),     // output wire s_axi_awready
        .s_axi_rready               (busD_s_axi_rready),      // input wire s_axi_rready
        .s_axi_rvalid               (busD_s_axi_rvalid),      // output wire s_axi_rvalid
        .s_axi_rdata                (busD_s_axi_rdata),       // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp                (busD_s_axi_rresp),       // output wire [1 : 0] s_axi_rresp
        .s_axi_wvalid               (busD_s_axi_wvalid),      // input wire s_axi_wvalid
        .s_axi_wdata                (busD_s_axi_wdata),       // input wire [31 : 0] s_axi_wdata
        .s_axi_wready               (busD_s_axi_wready),      // output wire s_axi_wready
        .s_axi_wstrb                (busD_s_axi_wstrb),       // input wire [3 : 0] s_axi_wstrb
        .s_axi_bready               (busD_s_axi_bready),      // input wire s_axi_bready
        .s_axi_bvalid               (busD_s_axi_bvalid),      // output wire s_axi_bvalid
        .s_axi_bresp                (busD_s_axi_bresp),       // output wire [1 : 0] s_axi_bresp
        .ctrl_reg1                  (iod_ctrl_reg1[3]),         // output wire [31 : 0] ctrl_reg1
        .ctrl_reg2                  (iod_ctrl_reg2[3]),         // output wire [31 : 0] ctrl_reg2
        .ctrl_reg3                  (iod_ctrl_reg3[3]),         // output wire [31 : 0] ctrl_reg3
        .ctrl_reg4                  (iod_ctrl_reg4[3]),         // output wire [31 : 0] ctrl_reg4
        .ctrl_reg5                  (iod_ctrl_reg5[3]),         // output wire [31 : 0] ctrl_reg5
        .ctrl_reg6                  (iod_ctrl_reg6[3]),         // output wire [31 : 0] ctrl_reg6
        .ctrl_reg7                  (iod_ctrl_reg7[3]),         // output wire [31 : 0] ctrl_reg7
        .ctrl_reg8                  (iod_ctrl_reg8[3]),         // output wire [31 : 0] ctrl_reg8
        .rst_ctrl_reg1              (iod_rst_ctrl_reg1[3]),                     // input wire rst_ctrl_reg1
        .rst_ctrl_reg2              (iod_rst_ctrl_reg2[3]),                     // input wire rst_ctrl_reg2
        .rst_ctrl_reg3              (iod_rst_ctrl_reg3[3]),                     // input wire rst_ctrl_reg3
        .rst_ctrl_reg4              (iod_rst_ctrl_reg4[3]),                     // input wire rst_ctrl_reg4
        .rst_ctrl_reg5              (iod_rst_ctrl_reg5[3]),                     // input wire rst_ctrl_reg5
        .rst_ctrl_reg6              (iod_rst_ctrl_reg6[3]),                     // input wire rst_ctrl_reg6
        .rst_ctrl_reg7              (iod_rst_ctrl_reg7[3]),                     // input wire rst_ctrl_reg7
        .rst_ctrl_reg8              (iod_rst_ctrl_reg8[3]),                     // input wire rst_ctrl_reg8
        .status_reg1                (iod_status_reg1[3]),       // input wire [31 : 0] status_reg1
        .status_reg2                (iod_status_reg2[3]),       // input wire [31 : 0] status_reg2
        .status_reg3                (iod_status_reg3[3]),       // input wire [31 : 0] status_reg3
        .status_reg4                (iod_status_reg4[3]),       // input wire [31 : 0] status_reg4
        .status_reg5                (iod_status_reg5[3]),       // input wire [31 : 0] status_reg5
        .status_reg6                (iod_status_reg6[3]),       // input wire [31 : 0] status_reg6
        .status_reg7                (iod_status_reg7[3]),       // input wire [31 : 0] status_reg7
        .status_reg8                (iod_status_reg8[3])        // input wire [31 : 0] status_reg8
    ); 
                 
     
     //******* HSSIO IP instances********//
     rx_bus0 #(
            . RIU_RST_FANOUT  (16'd2),
            . APP_RST_FANOUT  (16'd30),
            . STROBE_PAT1 (STROBE_PAT1), 
            . STROBE_PAT2 (STROBE_PAT2)  
         )ch0_i(
        .app_clk                    (app_clk),					//clk for data capture from the IP
        .riu_clk                    (riu_clk),					
        .sw_rst_app                 (sw_rst_app[29:0]),         //sw_rst wrt app_clk - from clock manager
        .sw_rst_riu                 (sw_rst_riu[1:0]),          //sw_rst wrt riu_clk - from clock manager
	//ADC signals
		.strobe_rx_p                (strobe_rx_p[0]),
        .strobe_rx_n                (strobe_rx_n[0]),
        .rx_clk_p                   (rx_clk_p[0]),
        .rx_clk_n                   (rx_clk_n[0]),
        .rx_data_p                  (rx_data_p[11:0]),   
        .rx_data_n                  (rx_data_n[11:0]),
		
        .fifo_rd_en                 (fifo_rd_en),
        .hssio_fifo_rd_en_out       (hssio_fifo_rd_en[0]),
        .hssio_mult_fifo_rd_en      (hssio_mult_fifo_rd_en), 	//multi bank IP in-built fifo rd enable 
        .rx_start_sync              (rx_start_sync_app),		// signal to trigger bitslip calibration
        
        .fifo_data_out              (fifo_out_rx0),				
        .deser_clk_o                (pll_clk_rx0),					//HSSIO IP pll clk out 0				
        .hssio_intf_rdy             (rx_intf_rdy[0]),				//HSSIO IP interface ready
        .hssio_pll0_locked          (rx_pll0_locked[0]),			//HSSIO IP pll lock
        .hssio_multi_intf_lock_in   (rx_multibank_pll0_locked_riu), //multi bank pll locked 
        .hssio_multi_intf_rdy_in    (rx_multibank_intf_rdy),		// multi bank interface ready
        .fifo_empty                 (fifo_empty_rx[0]),
        .fifo_valid                 (fifo_valid_rx[0]),
        .lane_rdy                   (lane_rdy[0]),					// Signal to indicate lane sync completion 
	//IO delay ctrl, status registers 			
        .iod_ctrl_reg1              (iod_ctrl_reg1[0]),  
        .iod_ctrl_reg2              (iod_ctrl_reg2[0]),                        
        .iod_ctrl_reg3              (iod_ctrl_reg3[0]),                        
        .iod_ctrl_reg4              (iod_ctrl_reg4[0]),                        
        .iod_ctrl_reg5              (iod_ctrl_reg5[0]),                        
        .iod_ctrl_reg6              (iod_ctrl_reg6[0]),                        
        .iod_ctrl_reg7              (iod_ctrl_reg7[0]),                        
        .iod_ctrl_reg8              (iod_ctrl_reg8[0]),                        
                               
        .iod_rst_ctrl_reg1          (iod_rst_ctrl_reg1[0]),		 //reset ctrl registers
        .iod_rst_ctrl_reg2          (iod_rst_ctrl_reg2[0]),      //reset ctrl registers
        .iod_rst_ctrl_reg3          (iod_rst_ctrl_reg3[0]),      //reset ctrl registers
        .iod_rst_ctrl_reg4          (iod_rst_ctrl_reg4[0]),      //reset ctrl registers
        .iod_rst_ctrl_reg5          (iod_rst_ctrl_reg5[0]),      //reset ctrl registers
        .iod_rst_ctrl_reg6          (iod_rst_ctrl_reg6[0]),      //reset ctrl registers
        .iod_rst_ctrl_reg7          (iod_rst_ctrl_reg7[0]),      //reset ctrl registers
        .iod_rst_ctrl_reg8          (iod_rst_ctrl_reg8[0]),      //reset ctrl registers                                    
                                
        .iod_status_reg1            (iod_status_reg1[0]),   
        .iod_status_reg2            (iod_status_reg2[0]),                      
        .iod_status_reg3            (iod_status_reg3[0]),                      
        .iod_status_reg4            (iod_status_reg4[0]),                      
        .iod_status_reg5            (iod_status_reg5[0]),                      
        .iod_status_reg6            (iod_status_reg6[0]),                      
        .iod_status_reg7            (iod_status_reg7[0]),                      
        .iod_status_reg8            (iod_status_reg8[0])                       
        );
    
    rx_bus1 #(
            . RIU_RST_FANOUT  (16'd2),
            . APP_RST_FANOUT  (16'd30),
            . STROBE_PAT1 (STROBE_PAT1), 
            . STROBE_PAT2 (STROBE_PAT2)  
         )ch1_i(
        .app_clk                    (app_clk),					//clk for data capture from the IP
        .riu_clk                    (riu_clk),                 
        .sw_rst_app                 (sw_rst_app[59:30]),        //sw_rst wrt app_clk - from clock manager
        .sw_rst_riu                 (sw_rst_riu[3:2]),          //sw_rst wrt riu_clk - from clock manager
	//ADC signals		                                            
		.strobe_rx_p                (strobe_rx_p[1]),           
        .strobe_rx_n                (strobe_rx_n[1]),           
        .rx_clk_p                   (rx_clk_p[1]),              
        .rx_clk_n                   (rx_clk_n[1]),              
        .rx_data_p                  (rx_data_p[23:12]),         
        .rx_data_n                  (rx_data_n[23:12]),         
		                                                        
        .fifo_rd_en                 (fifo_rd_en),               
        .hssio_fifo_rd_en_out       (hssio_fifo_rd_en[1]),      
        .hssio_mult_fifo_rd_en      (hssio_mult_fifo_rd_en),    //multi bank IP in-built fifo rd enable 
        .rx_start_sync              (rx_start_sync_app),        // signal to trigger bitslip calibration
                                                                
        .fifo_data_out              (fifo_out_rx1),             
        .deser_clk_o                (),                         	//HSSIO IP pll clk out 0				
        .hssio_intf_rdy             (rx_intf_rdy[1]),           	//HSSIO IP interface ready
        .hssio_pll0_locked          (rx_pll0_locked[1]),        	//HSSIO IP pll lock
        .hssio_multi_intf_lock_in   (rx_multibank_pll0_locked_riu), //multi bank pll locked 
        .hssio_multi_intf_rdy_in    (rx_multibank_intf_rdy),    	// multi bank interface ready
        .fifo_empty                 (fifo_empty_rx[1]),         
        .fifo_valid                 (fifo_valid_rx[1]),         
        .lane_rdy                   (lane_rdy[1]),              	// Signal to indicate lane sync completion 
	//IO delay ctrl, status registers 	       
        .iod_ctrl_reg1              (iod_ctrl_reg1[1]),        
        .iod_ctrl_reg2              (iod_ctrl_reg2[1]),                        
        .iod_ctrl_reg3              (iod_ctrl_reg3[1]),                        
        .iod_ctrl_reg4              (iod_ctrl_reg4[1]),                        
        .iod_ctrl_reg5              (iod_ctrl_reg5[1]),                        
        .iod_ctrl_reg6              (iod_ctrl_reg6[1]),                        
        .iod_ctrl_reg7              (iod_ctrl_reg7[1]),                        
        .iod_ctrl_reg8              (iod_ctrl_reg8[1]),     
                                    
        .iod_rst_ctrl_reg1          (iod_rst_ctrl_reg1[1]),		 //reset ctrl registers
        .iod_rst_ctrl_reg2          (iod_rst_ctrl_reg2[1]),      //reset ctrl registers
        .iod_rst_ctrl_reg3          (iod_rst_ctrl_reg3[1]),      //reset ctrl registers
        .iod_rst_ctrl_reg4          (iod_rst_ctrl_reg4[1]),      //reset ctrl registers
        .iod_rst_ctrl_reg5          (iod_rst_ctrl_reg5[1]),      //reset ctrl registers
        .iod_rst_ctrl_reg6          (iod_rst_ctrl_reg6[1]),      //reset ctrl registers
        .iod_rst_ctrl_reg7          (iod_rst_ctrl_reg7[1]),      //reset ctrl registers
        .iod_rst_ctrl_reg8          (iod_rst_ctrl_reg8[1]),   	 //reset ctrl registers                 
                                    
        .iod_status_reg1            (iod_status_reg1[1]),  
        .iod_status_reg2            (iod_status_reg2[1]),                      
        .iod_status_reg3            (iod_status_reg3[1]),                      
        .iod_status_reg4            (iod_status_reg4[1]),                      
        .iod_status_reg5            (iod_status_reg5[1]),                      
        .iod_status_reg6            (iod_status_reg6[1]),                      
        .iod_status_reg7            (iod_status_reg7[1]),                      
        .iod_status_reg8            (iod_status_reg8[1])         
        );
        
                   
    rx_bus2  #(
            . RIU_RST_FANOUT  (16'd2),
            . APP_RST_FANOUT  (16'd30),
            . STROBE_PAT1 (STROBE_PAT1),  
            . STROBE_PAT2 (STROBE_PAT2)  
        )ch2_i(
        .app_clk                    (app_clk),                  //clk for data capture from the IP
        .riu_clk                    (riu_clk),             
        .sw_rst_app                 (sw_rst_app[89:60]),        //sw_rst wrt app_clk - from clock manager
        .sw_rst_riu                 (sw_rst_riu[5:4]),          //sw_rst wrt riu_clk - from clock manager
	//ADC signals		                                            
		.strobe_rx_p                (strobe_rx_p[2]),           
        .strobe_rx_n                (strobe_rx_n[2]),           
        .rx_clk_p                   (rx_clk_p[2]),              
        .rx_clk_n                   (rx_clk_n[2]),              
        .rx_data_p                  (rx_data_p[35:24]),         
        .rx_data_n                  (rx_data_n[35:24]),         
		                                                        
        .fifo_rd_en                 (fifo_rd_en),               
        .hssio_fifo_rd_en_out       (hssio_fifo_rd_en[2]),      
        .hssio_mult_fifo_rd_en      (hssio_mult_fifo_rd_en),    //multi bank IP in-built fifo rd enable 
        .rx_start_sync              (rx_start_sync_app),        // signal to trigger bitslip calibration
                                                                
        .fifo_data_out              (fifo_out_rx2),             
        .deser_clk_o                (),                         	//HSSIO IP pll clk out 0				
        .hssio_intf_rdy             (rx_intf_rdy[2]),           	//HSSIO IP interface ready
        .hssio_pll0_locked          (rx_pll0_locked[2]),        	//HSSIO IP pll lock
        .hssio_multi_intf_lock_in   (rx_multibank_pll0_locked_riu), //multi bank pll locked 
        .hssio_multi_intf_rdy_in    (rx_multibank_intf_rdy),    	// multi bank interface ready
        .fifo_empty                 (fifo_empty_rx[2]),         
        .fifo_valid                 (fifo_valid_rx[2]),         
        .lane_rdy                   (lane_rdy[2]),              	// Signal to indicate lane sync completion 
	//IO delay ctrl, status registers 	       
        .iod_ctrl_reg1              (iod_ctrl_reg1[2]),    
        .iod_ctrl_reg2              (iod_ctrl_reg2[2]),                        
        .iod_ctrl_reg3              (iod_ctrl_reg3[2]),                        
        .iod_ctrl_reg4              (iod_ctrl_reg4[2]),                        
        .iod_ctrl_reg5              (iod_ctrl_reg5[2]),                        
        .iod_ctrl_reg6              (iod_ctrl_reg6[2]),                        
        .iod_ctrl_reg7              (iod_ctrl_reg7[2]),                        
        .iod_ctrl_reg8              (iod_ctrl_reg8[2]),                        
                                   
        .iod_rst_ctrl_reg1          (iod_rst_ctrl_reg1[2]),	//reset ctrl registers
        .iod_rst_ctrl_reg2          (iod_rst_ctrl_reg2[2]), //reset ctrl registers
        .iod_rst_ctrl_reg3          (iod_rst_ctrl_reg3[2]), //reset ctrl registers
        .iod_rst_ctrl_reg4          (iod_rst_ctrl_reg4[2]), //reset ctrl registers
        .iod_rst_ctrl_reg5          (iod_rst_ctrl_reg5[2]), //reset ctrl registers
        .iod_rst_ctrl_reg6          (iod_rst_ctrl_reg6[2]), //reset ctrl registers
        .iod_rst_ctrl_reg7          (iod_rst_ctrl_reg7[2]), //reset ctrl registers
        .iod_rst_ctrl_reg8          (iod_rst_ctrl_reg8[2]), //reset ctrl registers
                                 
        .iod_status_reg1            (iod_status_reg1[2]), 
        .iod_status_reg2            (iod_status_reg2[2]),                      
        .iod_status_reg3            (iod_status_reg3[2]),                      
        .iod_status_reg4            (iod_status_reg4[2]),                      
        .iod_status_reg5            (iod_status_reg5[2]),                      
        .iod_status_reg6            (iod_status_reg6[2]),                      
        .iod_status_reg7            (iod_status_reg7[2]),                      
        .iod_status_reg8            (iod_status_reg8[2])   
        );
                        
    rx_bus3  #(
            . RIU_RST_FANOUT  (16'd2),
            . APP_RST_FANOUT  (16'd30),
            . STROBE_PAT1 (STROBE_PAT1), 
            . STROBE_PAT2 (STROBE_PAT2)  
        )ch3_i(
        .app_clk                    (app_clk),                  //clk for data capture from the IP
        .riu_clk                    (riu_clk),                  //sw_rst wrt app_clk - from clock manager
        .sw_rst_app                 (sw_rst_app[119:90]), 		//sw_rst wrt app_clk - from clock manager
        .sw_rst_riu                 (sw_rst_riu[7:6]),          //sw_rst wrt riu_clk - from clock manager
	//ADC signals		                                            
		.strobe_rx_p                (strobe_rx_p[3]),           
        .strobe_rx_n                (strobe_rx_n[3]),           
        .rx_clk_p                   (rx_clk_p[3]),              
        .rx_clk_n                   (rx_clk_n[3]),              
        .rx_data_p                  (rx_data_p[47:36]),         
        .rx_data_n                  (rx_data_n[47:36]),         
		                                                        
        .fifo_rd_en                 (fifo_rd_en),               
        .hssio_fifo_rd_en_out       (hssio_fifo_rd_en[3]),      
        .hssio_mult_fifo_rd_en      (hssio_mult_fifo_rd_en),       //multi bank IP in-built fifo rd enable 
        .rx_start_sync              (rx_start_sync_app),           // signal to trigger bitslip calibration
                                                                
        .fifo_data_out              (fifo_out_rx3),             
        .deser_clk_o                (),                         	//HSSIO IP pll clk out 0				
        .hssio_intf_rdy             (rx_intf_rdy[3]),           	//HSSIO IP interface ready
        .hssio_pll0_locked          (rx_pll0_locked[3]),        	//HSSIO IP pll lock
        .hssio_multi_intf_lock_in   (rx_multibank_pll0_locked_riu), //multi bank pll locked 
        .hssio_multi_intf_rdy_in    (rx_multibank_intf_rdy),    	// multi bank interface ready
        .fifo_empty                 (fifo_empty_rx[3]),         
        .fifo_valid                 (fifo_valid_rx[3]),         
        .lane_rdy                   (lane_rdy[3]),              	// Signal to indicate lane sync completion 
	//IO delay ctrl, status registers                               
        .iod_ctrl_reg1              (iod_ctrl_reg1[3]),         
        .iod_ctrl_reg2              (iod_ctrl_reg2[3]),                            
        .iod_ctrl_reg3              (iod_ctrl_reg3[3]),                            
        .iod_ctrl_reg4              (iod_ctrl_reg4[3]),                            
        .iod_ctrl_reg5              (iod_ctrl_reg5[3]),                            
        .iod_ctrl_reg6              (iod_ctrl_reg6[3]),                            
        .iod_ctrl_reg7              (iod_ctrl_reg7[3]),                            
        .iod_ctrl_reg8              (iod_ctrl_reg8[3]),                        
                                                                
        .iod_rst_ctrl_reg1          (iod_rst_ctrl_reg1[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg2          (iod_rst_ctrl_reg2[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg3          (iod_rst_ctrl_reg3[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg4          (iod_rst_ctrl_reg4[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg5          (iod_rst_ctrl_reg5[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg6          (iod_rst_ctrl_reg6[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg7          (iod_rst_ctrl_reg7[3]),      //reset ctrl registers
        .iod_rst_ctrl_reg8          (iod_rst_ctrl_reg8[3]),      //reset ctrl registers                                   
                                    
        .iod_status_reg1            (iod_status_reg1[3]),   
        .iod_status_reg2            (iod_status_reg2[3]),           
        .iod_status_reg3            (iod_status_reg3[3]),           
        .iod_status_reg4            (iod_status_reg4[3]),           
        .iod_status_reg5            (iod_status_reg5[3]),           
        .iod_status_reg6            (iod_status_reg6[3]),           
        .iod_status_reg7            (iod_status_reg7[3]),                      
        .iod_status_reg8            (iod_status_reg8[3])         
        );  

	/* Reason for CE BUFG : Untill all the IP's are locked, all the logic operation 
	using the app clk should be in rst state */

    BUFGCE #( .CE_TYPE("SYNC"))                     //ASYN/SYNC
    pll_bufg (
      .O        (app_clk),                          // 1-bit output: Buffer
      .CE       (rx_multibank_pll0_locked),         // 1-bit input: Buffer enable
      .I        (pll_clk_rx0)                       // 1-bit input: Buffer
    );      

	//synchronising with RIU clk domain
    always @ (posedge riu_clk) 
        rx_sync_riu	<=	lane_rdy_riu_ctrl ^ rx_sync_polarity; 

	//-------------------assign statements------------------------------- 
    assign  rx_rst_done         		=   rx_multibank_intf_rdy_riu;
    assign  rx_sync             		=   rx_sync_app; //denotes sync is done at rx
    assign  rx_sync_polarity    		=   ctrl_reg1_out[0]; // depending on polarity of sync pin in adc,value is updated
    assign  rx_start_sync       		=   ctrl_reg2_out[0];
    assign  status_reg1_in      		=   {{31'b0},{rx_rst_done}}; //once all IPs are ready, rx_rst_done bit is set in register   
    assign  status_reg2_in      		=   {{31'b0},{rx_sync_riu}};    //rx_sync is set once all teh banks are synchronised 
 
//user fifo data out signals
    assign  busA_fifo_data_out           =   fifo_out_rx0[95:0];  
    assign  busB_fifo_data_out           =   fifo_out_rx1[95:0];
    assign  busC_fifo_data_out           =   fifo_out_rx2[95:0];
    assign  busD_fifo_data_out           =   fifo_out_rx3[95:0];       
    assign  busA_fifo_strb_out           =   fifo_out_rx0[103:96];
    assign  busB_fifo_strb_out           =   fifo_out_rx1[103:96];
    assign  busC_fifo_strb_out           =   fifo_out_rx2[103:96];
    assign  busD_fifo_strb_out           =   fifo_out_rx3[103:96];
    assign  busA_fifo_valid_out          =   fifo_valid_rx[0];
    assign  busB_fifo_valid_out          =   fifo_valid_rx[1];
    assign  busC_fifo_valid_out          =   fifo_valid_rx[2];
    assign  busD_fifo_valid_out          =   fifo_valid_rx[3];
 
    assign  fifo_rd_en                  =  !(|( bank_in_active_app & (fifo_empty_rx)));
    assign  hssio_fifo_rd_en_ctrl       =  !(|( bank_in_active_app & (~hssio_fifo_rd_en_app)));
       
    assign  rx_multibank_pll0_locked    =  !(|( bank_in_active_riu & (~rx_pll0_locked_riu)));
    assign  rx_multibank_intf_rdy       =  !(|( bank_in_active_riu & (~rx_intf_rdy_riu)));

    assign  lane_rdy_riu_ctrl            =  !(|( bank_in_active_riu & (~lane_rdy_riu)));
    
    //LDEMUX configuration
    assign  bank_in_active               = 4'hF;//hardcoded for LDEMUX1 mode
// **************** Sync stages *****************
        
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i0       (
        .src_data   (rx_pll0_locked), //clock_domain : N/A
        .dest_clk   (riu_clk), 
        .dest_data  (rx_pll0_locked_riu)
    );
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i1       (
        .src_data   (rx_multibank_pll0_locked), //clock_domain: riu_clk 
        .dest_clk   (riu_clk),
        .dest_data  (rx_multibank_pll0_locked_riu)
    ); 
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i2       (
        .src_data   (rx_intf_rdy), //clock_domain : N/A
        .dest_clk   (riu_clk), 
        .dest_data  (rx_intf_rdy_riu)
    );
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i3       (
        .src_data   (rx_multibank_intf_rdy), //clock_domain: riu_clk 
        .dest_clk   (riu_clk), 
        .dest_data  (rx_multibank_intf_rdy_riu)
    ); 
    
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i4       (
    .src_data   (rx_sync_riu),        
    .dest_clk   (app_clk),              
    .dest_data  (rx_sync_app)
);
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i5       (
        .src_data   (hssio_fifo_rd_en), //Clock_domain: Each bit corresponds to each IP pll clk out 0
        .dest_clk   (app_clk), 
        .dest_data  (hssio_fifo_rd_en_app)
    );  

    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i6       (
        .src_data   (hssio_fifo_rd_en_ctrl), //Clock_domain: app clk
        .dest_clk   (app_clk), 
        .dest_data  (hssio_mult_fifo_rd_en)
    );
		
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i7       (
        .src_data   (lane_rdy), //Clock_domain: pll0_clkout0_0
        .dest_clk   (riu_clk), 
        .dest_data  (lane_rdy_riu)
    );  
     
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(1), .pTCQ(100)) 
    sync_stage_i8       (
        .src_data   (rx_start_sync),  //Clock_domain: riu_clk
        .dest_clk   (app_clk),              
        .dest_data  (rx_start_sync_app)
    );  

//-------------------sync stage for bank in active--------------------------
    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i9      (
        .src_data   (bank_in_active),     
        .dest_clk   (app_clk),              
        .dest_data  (bank_in_active_app)
    ); 

    sync_stage #(.C_SYNC_STAGE(2), .C_DW(4), .pTCQ(100)) 
    sync_stage_i10      (
        .src_data   (bank_in_active),        
        .dest_clk   (riu_clk),              
        .dest_data  (bank_in_active_riu)
	);                                         

     
//~~~~~~~~~~~********** DATA as sent by ADC *********~~~~~~~~~~// 

    assign  busA_sample0  	=   {busA_fifo_data_out[88+0],    busA_fifo_data_out[80+0],  busA_fifo_data_out[72+0],   busA_fifo_data_out[64+0],   busA_fifo_data_out[56+0],   busA_fifo_data_out[48+0],   busA_fifo_data_out[40+0],   busA_fifo_data_out[32+0],   busA_fifo_data_out[24+0],   busA_fifo_data_out[16+0],   busA_fifo_data_out[8+0],    busA_fifo_data_out[0+0]};            
    assign  busA_sample1  	=   {busA_fifo_data_out[88+1],    busA_fifo_data_out[80+1],  busA_fifo_data_out[72+1],   busA_fifo_data_out[64+1],   busA_fifo_data_out[56+1],   busA_fifo_data_out[48+1],   busA_fifo_data_out[40+1],   busA_fifo_data_out[32+1],   busA_fifo_data_out[24+1],   busA_fifo_data_out[16+1],   busA_fifo_data_out[8+1],    busA_fifo_data_out[0+1]};            
    assign  busA_sample2  	=   {busA_fifo_data_out[88+2],    busA_fifo_data_out[80+2],  busA_fifo_data_out[72+2],   busA_fifo_data_out[64+2],   busA_fifo_data_out[56+2],   busA_fifo_data_out[48+2],   busA_fifo_data_out[40+2],   busA_fifo_data_out[32+2],   busA_fifo_data_out[24+2],   busA_fifo_data_out[16+2],   busA_fifo_data_out[8+2],    busA_fifo_data_out[0+2]};            
    assign  busA_sample3  	=   {busA_fifo_data_out[88+3],    busA_fifo_data_out[80+3],  busA_fifo_data_out[72+3],   busA_fifo_data_out[64+3],   busA_fifo_data_out[56+3],   busA_fifo_data_out[48+3],   busA_fifo_data_out[40+3],   busA_fifo_data_out[32+3],   busA_fifo_data_out[24+3],   busA_fifo_data_out[16+3],   busA_fifo_data_out[8+3],    busA_fifo_data_out[0+3]};            
    assign  busA_sample4  	=   {busA_fifo_data_out[88+4],    busA_fifo_data_out[80+4],  busA_fifo_data_out[72+4],   busA_fifo_data_out[64+4],   busA_fifo_data_out[56+4],   busA_fifo_data_out[48+4],   busA_fifo_data_out[40+4],   busA_fifo_data_out[32+4],   busA_fifo_data_out[24+4],   busA_fifo_data_out[16+4],   busA_fifo_data_out[8+4],    busA_fifo_data_out[0+4]};            
    assign  busA_sample5  	=   {busA_fifo_data_out[88+5],    busA_fifo_data_out[80+5],  busA_fifo_data_out[72+5],   busA_fifo_data_out[64+5],   busA_fifo_data_out[56+5],   busA_fifo_data_out[48+5],   busA_fifo_data_out[40+5],   busA_fifo_data_out[32+5],   busA_fifo_data_out[24+5],   busA_fifo_data_out[16+5],   busA_fifo_data_out[8+5],    busA_fifo_data_out[0+5]};            
    assign  busA_sample6  	=   {busA_fifo_data_out[88+6],    busA_fifo_data_out[80+6],  busA_fifo_data_out[72+6],   busA_fifo_data_out[64+6],   busA_fifo_data_out[56+6],   busA_fifo_data_out[48+6],   busA_fifo_data_out[40+6],   busA_fifo_data_out[32+6],   busA_fifo_data_out[24+6],   busA_fifo_data_out[16+6],   busA_fifo_data_out[8+6],    busA_fifo_data_out[0+6]};            
    assign  busA_sample7  	=   {busA_fifo_data_out[88+7],    busA_fifo_data_out[80+7],  busA_fifo_data_out[72+7],   busA_fifo_data_out[64+7],   busA_fifo_data_out[56+7],   busA_fifo_data_out[48+7],   busA_fifo_data_out[40+7],   busA_fifo_data_out[32+7],   busA_fifo_data_out[24+7],   busA_fifo_data_out[16+7],   busA_fifo_data_out[8+7],    busA_fifo_data_out[0+7]};            
					
    assign  busB_sample0  	=   {busB_fifo_data_out[88+0],    busB_fifo_data_out[80+0],  busB_fifo_data_out[72+0],   busB_fifo_data_out[64+0],   busB_fifo_data_out[56+0],   busB_fifo_data_out[48+0],   busB_fifo_data_out[40+0],   busB_fifo_data_out[32+0],   busB_fifo_data_out[24+0],   busB_fifo_data_out[16+0],   busB_fifo_data_out[8+0],    busB_fifo_data_out[0+0]};
    assign  busB_sample1  	=   {busB_fifo_data_out[88+1],    busB_fifo_data_out[80+1],  busB_fifo_data_out[72+1],   busB_fifo_data_out[64+1],   busB_fifo_data_out[56+1],   busB_fifo_data_out[48+1],   busB_fifo_data_out[40+1],   busB_fifo_data_out[32+1],   busB_fifo_data_out[24+1],   busB_fifo_data_out[16+1],   busB_fifo_data_out[8+1],    busB_fifo_data_out[0+1]};
    assign  busB_sample2  	=   {busB_fifo_data_out[88+2],    busB_fifo_data_out[80+2],  busB_fifo_data_out[72+2],   busB_fifo_data_out[64+2],   busB_fifo_data_out[56+2],   busB_fifo_data_out[48+2],   busB_fifo_data_out[40+2],   busB_fifo_data_out[32+2],   busB_fifo_data_out[24+2],   busB_fifo_data_out[16+2],   busB_fifo_data_out[8+2],    busB_fifo_data_out[0+2]};
    assign  busB_sample3  	=   {busB_fifo_data_out[88+3],    busB_fifo_data_out[80+3],  busB_fifo_data_out[72+3],   busB_fifo_data_out[64+3],   busB_fifo_data_out[56+3],   busB_fifo_data_out[48+3],   busB_fifo_data_out[40+3],   busB_fifo_data_out[32+3],   busB_fifo_data_out[24+3],   busB_fifo_data_out[16+3],   busB_fifo_data_out[8+3],    busB_fifo_data_out[0+3]};
    assign  busB_sample4  	=   {busB_fifo_data_out[88+4],    busB_fifo_data_out[80+4],  busB_fifo_data_out[72+4],   busB_fifo_data_out[64+4],   busB_fifo_data_out[56+4],   busB_fifo_data_out[48+4],   busB_fifo_data_out[40+4],   busB_fifo_data_out[32+4],   busB_fifo_data_out[24+4],   busB_fifo_data_out[16+4],   busB_fifo_data_out[8+4],    busB_fifo_data_out[0+4]};
    assign  busB_sample5  	=   {busB_fifo_data_out[88+5],    busB_fifo_data_out[80+5],  busB_fifo_data_out[72+5],   busB_fifo_data_out[64+5],   busB_fifo_data_out[56+5],   busB_fifo_data_out[48+5],   busB_fifo_data_out[40+5],   busB_fifo_data_out[32+5],   busB_fifo_data_out[24+5],   busB_fifo_data_out[16+5],   busB_fifo_data_out[8+5],    busB_fifo_data_out[0+5]};
    assign  busB_sample6  	=   {busB_fifo_data_out[88+6],    busB_fifo_data_out[80+6],  busB_fifo_data_out[72+6],   busB_fifo_data_out[64+6],   busB_fifo_data_out[56+6],   busB_fifo_data_out[48+6],   busB_fifo_data_out[40+6],   busB_fifo_data_out[32+6],   busB_fifo_data_out[24+6],   busB_fifo_data_out[16+6],   busB_fifo_data_out[8+6],    busB_fifo_data_out[0+6]};
    assign  busB_sample7  	=   {busB_fifo_data_out[88+7],    busB_fifo_data_out[80+7],  busB_fifo_data_out[72+7],   busB_fifo_data_out[64+7],   busB_fifo_data_out[56+7],   busB_fifo_data_out[48+7],   busB_fifo_data_out[40+7],   busB_fifo_data_out[32+7],   busB_fifo_data_out[24+7],   busB_fifo_data_out[16+7],   busB_fifo_data_out[8+7],    busB_fifo_data_out[0+7]};
					
    assign  busC_sample0  	=   {busC_fifo_data_out[88+0],    busC_fifo_data_out[80+0],  busC_fifo_data_out[72+0],   busC_fifo_data_out[64+0],   busC_fifo_data_out[56+0],   busC_fifo_data_out[48+0],   busC_fifo_data_out[40+0],   busC_fifo_data_out[32+0],   busC_fifo_data_out[24+0],   busC_fifo_data_out[16+0],   busC_fifo_data_out[8+0],    busC_fifo_data_out[0+0]};
    assign  busC_sample1  	=   {busC_fifo_data_out[88+1],    busC_fifo_data_out[80+1],  busC_fifo_data_out[72+1],   busC_fifo_data_out[64+1],   busC_fifo_data_out[56+1],   busC_fifo_data_out[48+1],   busC_fifo_data_out[40+1],   busC_fifo_data_out[32+1],   busC_fifo_data_out[24+1],   busC_fifo_data_out[16+1],   busC_fifo_data_out[8+1],    busC_fifo_data_out[0+1]};
    assign  busC_sample2  	=   {busC_fifo_data_out[88+2],    busC_fifo_data_out[80+2],  busC_fifo_data_out[72+2],   busC_fifo_data_out[64+2],   busC_fifo_data_out[56+2],   busC_fifo_data_out[48+2],   busC_fifo_data_out[40+2],   busC_fifo_data_out[32+2],   busC_fifo_data_out[24+2],   busC_fifo_data_out[16+2],   busC_fifo_data_out[8+2],    busC_fifo_data_out[0+2]};
    assign  busC_sample3  	=   {busC_fifo_data_out[88+3],    busC_fifo_data_out[80+3],  busC_fifo_data_out[72+3],   busC_fifo_data_out[64+3],   busC_fifo_data_out[56+3],   busC_fifo_data_out[48+3],   busC_fifo_data_out[40+3],   busC_fifo_data_out[32+3],   busC_fifo_data_out[24+3],   busC_fifo_data_out[16+3],   busC_fifo_data_out[8+3],    busC_fifo_data_out[0+3]};
    assign  busC_sample4  	=   {busC_fifo_data_out[88+4],    busC_fifo_data_out[80+4],  busC_fifo_data_out[72+4],   busC_fifo_data_out[64+4],   busC_fifo_data_out[56+4],   busC_fifo_data_out[48+4],   busC_fifo_data_out[40+4],   busC_fifo_data_out[32+4],   busC_fifo_data_out[24+4],   busC_fifo_data_out[16+4],   busC_fifo_data_out[8+4],    busC_fifo_data_out[0+4]};
    assign  busC_sample5  	=   {busC_fifo_data_out[88+5],    busC_fifo_data_out[80+5],  busC_fifo_data_out[72+5],   busC_fifo_data_out[64+5],   busC_fifo_data_out[56+5],   busC_fifo_data_out[48+5],   busC_fifo_data_out[40+5],   busC_fifo_data_out[32+5],   busC_fifo_data_out[24+5],   busC_fifo_data_out[16+5],   busC_fifo_data_out[8+5],    busC_fifo_data_out[0+5]};
    assign  busC_sample6  	=   {busC_fifo_data_out[88+6],    busC_fifo_data_out[80+6],  busC_fifo_data_out[72+6],   busC_fifo_data_out[64+6],   busC_fifo_data_out[56+6],   busC_fifo_data_out[48+6],   busC_fifo_data_out[40+6],   busC_fifo_data_out[32+6],   busC_fifo_data_out[24+6],   busC_fifo_data_out[16+6],   busC_fifo_data_out[8+6],    busC_fifo_data_out[0+6]};
    assign  busC_sample7  	=   {busC_fifo_data_out[88+7],    busC_fifo_data_out[80+7],  busC_fifo_data_out[72+7],   busC_fifo_data_out[64+7],   busC_fifo_data_out[56+7],   busC_fifo_data_out[48+7],   busC_fifo_data_out[40+7],   busC_fifo_data_out[32+7],   busC_fifo_data_out[24+7],   busC_fifo_data_out[16+7],   busC_fifo_data_out[8+7],    busC_fifo_data_out[0+7]};    
					
    assign  busD_sample0  	=   {busD_fifo_data_out[88+0],    busD_fifo_data_out[80+0],  busD_fifo_data_out[72+0],   busD_fifo_data_out[64+0],   busD_fifo_data_out[56+0],   busD_fifo_data_out[48+0],   busD_fifo_data_out[40+0],   busD_fifo_data_out[32+0],   busD_fifo_data_out[24+0],   busD_fifo_data_out[16+0],   busD_fifo_data_out[8+0],    busD_fifo_data_out[0+0]};
    assign  busD_sample1  	=   {busD_fifo_data_out[88+1],    busD_fifo_data_out[80+1],  busD_fifo_data_out[72+1],   busD_fifo_data_out[64+1],   busD_fifo_data_out[56+1],   busD_fifo_data_out[48+1],   busD_fifo_data_out[40+1],   busD_fifo_data_out[32+1],   busD_fifo_data_out[24+1],   busD_fifo_data_out[16+1],   busD_fifo_data_out[8+1],    busD_fifo_data_out[0+1]};
    assign  busD_sample2  	=   {busD_fifo_data_out[88+2],    busD_fifo_data_out[80+2],  busD_fifo_data_out[72+2],   busD_fifo_data_out[64+2],   busD_fifo_data_out[56+2],   busD_fifo_data_out[48+2],   busD_fifo_data_out[40+2],   busD_fifo_data_out[32+2],   busD_fifo_data_out[24+2],   busD_fifo_data_out[16+2],   busD_fifo_data_out[8+2],    busD_fifo_data_out[0+2]};
    assign  busD_sample3  	=   {busD_fifo_data_out[88+3],    busD_fifo_data_out[80+3],  busD_fifo_data_out[72+3],   busD_fifo_data_out[64+3],   busD_fifo_data_out[56+3],   busD_fifo_data_out[48+3],   busD_fifo_data_out[40+3],   busD_fifo_data_out[32+3],   busD_fifo_data_out[24+3],   busD_fifo_data_out[16+3],   busD_fifo_data_out[8+3],    busD_fifo_data_out[0+3]};
    assign  busD_sample4  	=   {busD_fifo_data_out[88+4],    busD_fifo_data_out[80+4],  busD_fifo_data_out[72+4],   busD_fifo_data_out[64+4],   busD_fifo_data_out[56+4],   busD_fifo_data_out[48+4],   busD_fifo_data_out[40+4],   busD_fifo_data_out[32+4],   busD_fifo_data_out[24+4],   busD_fifo_data_out[16+4],   busD_fifo_data_out[8+4],    busD_fifo_data_out[0+4]};
    assign  busD_sample5  	=   {busD_fifo_data_out[88+5],    busD_fifo_data_out[80+5],  busD_fifo_data_out[72+5],   busD_fifo_data_out[64+5],   busD_fifo_data_out[56+5],   busD_fifo_data_out[48+5],   busD_fifo_data_out[40+5],   busD_fifo_data_out[32+5],   busD_fifo_data_out[24+5],   busD_fifo_data_out[16+5],   busD_fifo_data_out[8+5],    busD_fifo_data_out[0+5]};
    assign  busD_sample6  	=   {busD_fifo_data_out[88+6],    busD_fifo_data_out[80+6],  busD_fifo_data_out[72+6],   busD_fifo_data_out[64+6],   busD_fifo_data_out[56+6],   busD_fifo_data_out[48+6],   busD_fifo_data_out[40+6],   busD_fifo_data_out[32+6],   busD_fifo_data_out[24+6],   busD_fifo_data_out[16+6],   busD_fifo_data_out[8+6],    busD_fifo_data_out[0+6]};
    assign  busD_sample7  	=   {busD_fifo_data_out[88+7],    busD_fifo_data_out[80+7],  busD_fifo_data_out[72+7],   busD_fifo_data_out[64+7],   busD_fifo_data_out[56+7],   busD_fifo_data_out[48+7],   busD_fifo_data_out[40+7],   busD_fifo_data_out[32+7],   busD_fifo_data_out[24+7],   busD_fifo_data_out[16+7],   busD_fifo_data_out[8+7],    busD_fifo_data_out[0+7]};     
	
	//------strobe and valid -----------------------------	
	assign  busA_strb	  	=	busA_fifo_strb_out;  
	assign  busB_strb     	=	busB_fifo_strb_out;
	assign  busC_strb     	=	busC_fifo_strb_out;
	assign  busD_strb     	=	busD_fifo_strb_out;
		
	assign  busA_valid	  	=	busA_fifo_valid_out;
	assign  busB_valid    	=	busB_fifo_valid_out;
	assign  busC_valid    	=	busC_fifo_valid_out;
	assign  busD_valid    	=	busD_fifo_valid_out;
		
endmodule