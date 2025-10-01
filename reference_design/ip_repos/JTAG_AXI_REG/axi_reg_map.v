`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2018 16:09:48
// Design Name: 
// Module Name: axi_reg_map
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


module axi_reg_map (
clk,
reset_n,
	
s_axi_araddr,
s_axi_arvalid,
s_axi_arready,
		
s_axi_awaddr,
s_axi_awvalid,
s_axi_awready,
		
s_axi_rready,//read_en
s_axi_rvalid,//rddata_valid
s_axi_rdata,//dataout
s_axi_rresp,
	
s_axi_wvalid,//write_en
s_axi_wdata,//datain
s_axi_wready,
s_axi_wstrb,
	
s_axi_bready,
s_axi_bvalid,
s_axi_bresp,

ctrl_reg1, //registers with wr and rd access
ctrl_reg2, //registers with wr and rd access
ctrl_reg3, //registers with wr and rd access
ctrl_reg4, //registers with wr and rd access
ctrl_reg5, //registers with wr and rd access
ctrl_reg6, //registers with wr and rd access
ctrl_reg7, //registers with wr and rd access
ctrl_reg8, //registers with wr and rd access

rst_ctrl_reg1, //restore the register to default value
rst_ctrl_reg2, //restore the register to default value
rst_ctrl_reg3, //restore the register to default value
rst_ctrl_reg4, //restore the register to default value
rst_ctrl_reg5, //restore the register to default value
rst_ctrl_reg6, //restore the register to default value
rst_ctrl_reg7, //restore the register to default value
rst_ctrl_reg8, //restore the register to default value

status_reg1,//registers with rd access alone
status_reg2,//registers with rd access alone
status_reg3,//registers with rd access alone
status_reg4,//registers with rd access alone
status_reg5,//registers with rd access alone
status_reg6,//registers with rd access alone
status_reg7,//registers with rd access alone
status_reg8 //registers with rd access alone

);
//------------------default values for ctrl registers---------------

	parameter REG_1_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_2_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_3_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_4_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_5_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_6_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_7_CTRL_DEFAULT = 32'hAABBCCDD;
	parameter REG_8_CTRL_DEFAULT = 32'hAABBCCDD;

//-------------------address assignment--------------------------

	localparam  REG_1_CTRL_ADDR	=	16'h0001;
	localparam  REG_2_CTRL_ADDR	=	16'h0002;
	localparam  REG_3_CTRL_ADDR	=	16'h0003;
	localparam  REG_4_CTRL_ADDR	=	16'h0004;
	localparam  REG_5_CTRL_ADDR	=	16'h0005;
	localparam  REG_6_CTRL_ADDR	=	16'h0006;
	localparam  REG_7_CTRL_ADDR	=	16'h0007;
    localparam	REG_8_CTRL_ADDR	=	16'h0008;
	
	localparam	REG_1_STAT_ADDR =	16'h1001;
	localparam	REG_2_STAT_ADDR =	16'h1002;
	localparam	REG_3_STAT_ADDR =	16'h1003;
	localparam	REG_4_STAT_ADDR =	16'h1004;
	localparam	REG_5_STAT_ADDR =	16'h1005;
	localparam	REG_6_STAT_ADDR =	16'h1006;
	localparam	REG_7_STAT_ADDR =	16'h1007;
	localparam	REG_8_STAT_ADDR	=	16'h1008;
	
	localparam	DATA_WIDTH	=	32;
	localparam	ADDR_WIDTH	=	32;
	localparam  NUM_OF_REGS =    8;
//--------------------port declaration-------------------------	

	input			clk;
	input 			reset_n;
	
//axi signals	

	input   [ADDR_WIDTH-1:0]  	s_axi_araddr;
 	input   					s_axi_arvalid;
	output 						s_axi_arready;
		
	input   [ADDR_WIDTH-1:0]  	s_axi_awaddr;
	input   					s_axi_awvalid;
	output 						s_axi_awready;
					
    input           			s_axi_rready;//read_en
	output          			s_axi_rvalid;//rddata_valid
	output  [DATA_WIDTH-1:0]  	s_axi_rdata;//dataout
	output  [1:0]				s_axi_rresp;
	
	input           			s_axi_wvalid;//write_en
	input   [DATA_WIDTH-1:0]  	s_axi_wdata;//datain
	output  					s_axi_wready;
	input  	[3:0]				s_axi_wstrb;
				
	input						s_axi_bready;
	output						s_axi_bvalid;
	output	[1:0]				s_axi_bresp;
	
// 32'b registers
	
	output	[DATA_WIDTH-1:0]	ctrl_reg1;
	output	[DATA_WIDTH-1:0]	ctrl_reg2;
	output	[DATA_WIDTH-1:0]	ctrl_reg3;
	output	[DATA_WIDTH-1:0]	ctrl_reg4;
	output	[DATA_WIDTH-1:0]	ctrl_reg5;
	output	[DATA_WIDTH-1:0]	ctrl_reg6;
	output	[DATA_WIDTH-1:0]	ctrl_reg7;
	output	[DATA_WIDTH-1:0]	ctrl_reg8;
	
	input						rst_ctrl_reg1;
	input						rst_ctrl_reg2;
	input						rst_ctrl_reg3;
	input						rst_ctrl_reg4;
	input						rst_ctrl_reg5;
	input						rst_ctrl_reg6;
	input						rst_ctrl_reg7;
	input						rst_ctrl_reg8;
	
	input	[DATA_WIDTH-1:0]	status_reg1;
	input	[DATA_WIDTH-1:0]	status_reg2;
	input	[DATA_WIDTH-1:0]	status_reg3;
	input	[DATA_WIDTH-1:0]	status_reg4;
	input	[DATA_WIDTH-1:0]	status_reg5;
	input	[DATA_WIDTH-1:0]	status_reg6;
	input	[DATA_WIDTH-1:0]	status_reg7;
	input	[DATA_WIDTH-1:0]  	status_reg8;
	
//----------------------------signal declaration-------------------------	
	wire [ADDR_WIDTH-1:0]	s_axi_araddr;
	wire	   				s_axi_arvalid;
	reg						s_axi_arready;

	wire [ADDR_WIDTH-1:0] 	s_axi_awaddr;
	wire	    			s_axi_awvalid;
	reg		    			s_axi_awready;

	wire   	    			s_axi_rready;//read_en
	reg         			s_axi_rvalid;//rddata_valid
	reg	 [DATA_WIDTH-1:0] 	s_axi_rdata;//dataout
	wire [1:0]				s_axi_rresp;

	wire        			s_axi_wvalid;//write_en
	wire [DATA_WIDTH-1:0] 	s_axi_wdata;//datain
	reg						s_axi_wready;

	wire [3:0]				s_axi_wstrb;
	wire					s_axi_bready;
	reg						s_axi_bvalid;
	wire [1:0]				s_axi_bresp;
    
	reg  [DATA_WIDTH-1:0]	ctrl_reg1;
	reg  [DATA_WIDTH-1:0]	ctrl_reg2;
	reg  [DATA_WIDTH-1:0]	ctrl_reg3;
	reg  [DATA_WIDTH-1:0]	ctrl_reg4;
	reg  [DATA_WIDTH-1:0]	ctrl_reg5;
	reg  [DATA_WIDTH-1:0]	ctrl_reg6;
	reg  [DATA_WIDTH-1:0]	ctrl_reg7;
	reg  [DATA_WIDTH-1:0]	ctrl_reg8;
  
	reg [ADDR_WIDTH-1:0]	waddr, waddr_r;

    wire [NUM_OF_REGS-1:0]  rst_reg;
    
	assign s_axi_bresp = 2'b0;
	assign s_axi_rresp = 2'b0;
//-------------awready----------------------------------------------------
always@(posedge clk or negedge reset_n)
	begin
		if(!reset_n)
			s_axi_awready 		<= 1'b0;
		else if(s_axi_awready)
                s_axi_awready 	<= 1'b0;
		else if(s_axi_awvalid)
			s_axi_awready 		<= 1'b1;
		else
			s_axi_awready 		<= 1'b0;
	end	
//------------------wready-------------------------------------------------	
    //  FSM for storeing valid addr,wready and bvalid
    //reg to hold the state values
    reg     curr_state_wr;
    reg     nxt_state_wr;
    
    //state declaration
    localparam IDLE_WR      = 1'd0,
               WAIT_WVALID  = 1'd1;
    
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
		begin
            curr_state_wr  <= 1'd0;
			waddr_r		   <= 32'd0;
		end
        else
		begin
            curr_state_wr  <= nxt_state_wr;
			waddr_r		   <= waddr;
		end
    end
    
    // state definition and next state detection
    always @(*)
    begin
        nxt_state_wr    = curr_state_wr; //default state
        s_axi_wready    = 1'b0;
        waddr           = 32'd0;
        s_axi_bvalid    = 1'b0;
        case(curr_state_wr)
        IDLE_WR :
            begin
            s_axi_wready    = 1'b0;
            s_axi_bvalid    = 1'b0;
            s_axi_bvalid    = 1'b0;
                if(s_axi_awvalid)//check for valid addr
                begin
                    nxt_state_wr      = WAIT_WVALID;
                    waddr             = s_axi_awaddr;
                end
                else
                begin
                    nxt_state_wr      = IDLE_WR;
                    waddr             = 32'd0;
                end
            end
         WAIT_WVALID : //valid data txn completed and moves to idle
            begin
             s_axi_wready         	= 1'b1;
             waddr                	= waddr_r;
             if(s_axi_wvalid)
             begin
                 nxt_state_wr      = IDLE_WR;
                 s_axi_bvalid      = 1'b1; //after completing wr,send a pulse
             end
             else
             begin
                 nxt_state_wr       = WAIT_WVALID;
                 s_axi_bvalid       = 1'b0;
              end
            end           
        endcase
    end
//--------------------write--------------------------------------------	


	
always@(posedge clk or negedge reset_n)
	begin
		if(!reset_n)
		begin
            ctrl_reg1   <= REG_1_CTRL_DEFAULT;
            ctrl_reg2   <= REG_2_CTRL_DEFAULT;
            ctrl_reg3   <= REG_3_CTRL_DEFAULT;
            ctrl_reg4   <= REG_4_CTRL_DEFAULT;
            ctrl_reg5   <= REG_5_CTRL_DEFAULT;
            ctrl_reg6   <= REG_6_CTRL_DEFAULT;
            ctrl_reg7   <= REG_7_CTRL_DEFAULT;
            ctrl_reg8	<= REG_8_CTRL_DEFAULT;
		end
		else if(s_axi_wvalid)
			begin
			case (waddr_r[15:0])
				REG_1_CTRL_ADDR  :	ctrl_reg1   <=   s_axi_wdata;
				REG_2_CTRL_ADDR  :	ctrl_reg2   <=   s_axi_wdata;
				REG_3_CTRL_ADDR  :	ctrl_reg3   <=   s_axi_wdata;
				REG_4_CTRL_ADDR  :	ctrl_reg4   <=   s_axi_wdata;
				REG_5_CTRL_ADDR  :	ctrl_reg5   <=   s_axi_wdata;
				REG_6_CTRL_ADDR  :	ctrl_reg6   <=   s_axi_wdata;
				REG_7_CTRL_ADDR  :	ctrl_reg7   <=   s_axi_wdata;
				REG_8_CTRL_ADDR	 :	ctrl_reg8	<=	 s_axi_wdata;
			endcase
			end
		else
			begin
				if(rst_ctrl_reg1)
					ctrl_reg1   <= REG_1_CTRL_DEFAULT;
				else
					ctrl_reg1	<= ctrl_reg1;
				if(rst_ctrl_reg2)
					ctrl_reg2   <= REG_2_CTRL_DEFAULT;
				else
					ctrl_reg2	<= ctrl_reg2;
				if(rst_ctrl_reg3)
					ctrl_reg3   <= REG_3_CTRL_DEFAULT;
				else
					ctrl_reg3	<= ctrl_reg3;
				if(rst_ctrl_reg4)
					ctrl_reg4   <= REG_4_CTRL_DEFAULT;
				else
					ctrl_reg4	<= ctrl_reg4;
				if(rst_ctrl_reg5)
					ctrl_reg5   <= REG_5_CTRL_DEFAULT;
				else
					ctrl_reg5	<= ctrl_reg5;
				if(rst_ctrl_reg6)
					ctrl_reg6   <= REG_6_CTRL_DEFAULT;
				else
					ctrl_reg6	<= ctrl_reg6;
				if(rst_ctrl_reg7)
					ctrl_reg7   <= REG_7_CTRL_DEFAULT;
				else
					ctrl_reg7	<= ctrl_reg7;
				if(rst_ctrl_reg8)
					ctrl_reg8   <= REG_8_CTRL_DEFAULT;
				else
					ctrl_reg8	<= ctrl_reg8;
			end
	end

	
//----------------------arready---------------------------------------------	
always @(posedge clk or negedge reset_n)
	begin
		if(!reset_n)
			s_axi_arready <= 1'b0;
		else if(s_axi_arready)
            s_axi_arready <= 1'b0;
		else if(s_axi_arvalid)
			s_axi_arready <= 1'b1;
		else
			s_axi_arready <= 1'b0;
	end	
//---------------------rvalid-------------------------------------------
//valid should be asserted after arready and dessert after the transaction	

//  FSM to issue rvalid
//reg to hold the state values
reg 	curr_state_rd;
reg 	nxt_state_rd;

//state declaration
localparam IDLE_RD  		= 1'd0,
           ISSUE_RVALILD 	= 1'd1;

always @(posedge clk or posedge reset_n)
begin
    if(!reset_n)
		curr_state_rd  <= 1'd0;
    else
        curr_state_rd  <= nxt_state_rd;
end

// state definition and next state detection
always @(*)
begin
    nxt_state_rd 	= curr_state_rd; //default state
    s_axi_rvalid	= 1'b0;
    case(curr_state_rd)
    IDLE_RD :
        begin
		s_axi_rvalid	=	1'b0;
            if(s_axi_arvalid)
                nxt_state_rd 	= ISSUE_RVALILD;
			else
                nxt_state_rd 	= IDLE_RD;
		end
    ISSUE_RVALILD :
        begin
		s_axi_rvalid = 1'b1;
         if(s_axi_rready)//until master accepts the data, send valid
             nxt_state_rd = IDLE_RD;	 
         else
             nxt_state_rd = ISSUE_RVALILD;
		end           
    endcase
end

//------------------------read-------------------------------------
always @(posedge clk or negedge reset_n)
	begin
	if(!reset_n)
		s_axi_rdata <= 32'hDEADDEAD;
	else if(s_axi_arvalid) //once valid address is recieved,load the valid data
		begin
			case(s_axi_araddr[15:0])
			//reg values from lvds
				REG_1_STAT_ADDR	:	s_axi_rdata	<=	status_reg1;
				REG_2_STAT_ADDR	:	s_axi_rdata	<=	status_reg2;
				REG_3_STAT_ADDR	:	s_axi_rdata	<=	status_reg3;
				REG_4_STAT_ADDR	:	s_axi_rdata	<=	status_reg4;
				REG_5_STAT_ADDR	:	s_axi_rdata	<=	status_reg5;
				REG_6_STAT_ADDR	:	s_axi_rdata	<=	status_reg6;
				REG_7_STAT_ADDR	:	s_axi_rdata	<=	status_reg7;
				REG_8_STAT_ADDR	:	s_axi_rdata	<=	status_reg8;
				//read access to the reg writen from jtag
				REG_1_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg1;
				REG_2_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg2;
				REG_3_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg3;
				REG_4_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg4;
				REG_5_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg5;
				REG_6_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg6;
				REG_7_CTRL_ADDR  :  s_axi_rdata <=  ctrl_reg7;
				REG_8_CTRL_ADDR	 :	s_axi_rdata <=	ctrl_reg8;
				
				default			 :	s_axi_rdata <= 32'h0BAD0BAD;//accessing any other reg addr, throws bad
			endcase
		end
	else
		s_axi_rdata	<= s_axi_rdata;
	end

endmodule
