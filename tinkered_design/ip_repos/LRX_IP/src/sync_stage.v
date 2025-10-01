// (c) Copyright 2013 - 2015 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

`timescale 1 ps / 1 ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module sync_stage
#(
    parameter   C_SYNC_STAGE        = 2,
    parameter   C_DW                = 4,
    parameter   pTCQ                = 100
)
(
  input  wire  [C_DW-1:0]                 src_data,

  input  wire                             dest_clk,
  output wire  [C_DW-1:0]                 dest_data
);

(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_0;
(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_1;
(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_2;
(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_3;
(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_4;
(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_5;
(* async_reg = "true" *) reg [C_DW-1:0] sync_flop_6;

	always @ ( posedge dest_clk )
	begin
		sync_flop_0 <= #pTCQ src_data;
		sync_flop_1 <= #pTCQ sync_flop_0;
		sync_flop_2 <= #pTCQ sync_flop_1;
		sync_flop_3 <= #pTCQ sync_flop_2;
		sync_flop_4 <= #pTCQ sync_flop_3;
		sync_flop_5 <= #pTCQ sync_flop_4;
		sync_flop_6 <= #pTCQ sync_flop_5;
	end
	
	generate 
		if ( C_SYNC_STAGE == 1 )
		begin:sync1
			assign dest_data = sync_flop_0;
		end
		else if ( C_SYNC_STAGE == 2 )
		begin:sync2
			assign dest_data = sync_flop_1;
		end
		else if ( C_SYNC_STAGE == 3 )
		begin:sync3
			assign dest_data = sync_flop_2;
		end
		else if ( C_SYNC_STAGE == 4 )
		begin:sync4
			assign dest_data = sync_flop_3;
		end
		else if ( C_SYNC_STAGE == 5 )
		begin:sync5
			assign dest_data = sync_flop_4;
		end
		else if ( C_SYNC_STAGE == 6 )
		begin:sync6
			assign dest_data = sync_flop_5;
		end
		else if ( C_SYNC_STAGE == 7 )
		begin:sync7
			assign dest_data = sync_flop_6;
		end
	endgenerate

endmodule
