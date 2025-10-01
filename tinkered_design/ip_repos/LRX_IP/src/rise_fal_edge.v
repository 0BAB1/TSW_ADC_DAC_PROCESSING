module rise_fal_edge(
	clk_in		,	//input clk
	rst_in		,	//active high rst
	signal_in	,	//1b signal to which rise and falling edge to be detected
	rise_out	, 	// output pulse of rising edge
	fall_out		//output pulse of falling edge
);

	input clk_in;		
	input rst_in;		
	input signal_in;	
	output rise_out;	
	output fall_out;	
	
	reg signal_in_r;
	
	always @(posedge clk_in or posedge rst_in)
	begin
		if(rst_in)
			signal_in_r	<= 1'b0;
		else
			signal_in_r	<= #20 signal_in;
	end
	
	assign	rise_out	= (~signal_in_r) & signal_in;
	
	assign	fall_out	= signal_in_r & (~signal_in);
	
endmodule