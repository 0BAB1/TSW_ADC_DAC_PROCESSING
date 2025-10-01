`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2018 03:52:40 PM
// Design Name: 
// Module Name: top_temp_adc_data_capture
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


module top_dummy_adc_data_capture
	#( 
		parameter     ADC_RESOLUTION     	=   'd12  
    )
	(
	input  app_clk,

    input  [7:0]    busA_strb,   // Strobe from busA
                    busB_strb,   // Strobe from busB
                    busC_strb,   // Strobe from busC
                    busD_strb,   // Strobe from busD

    input   busA_valid,  // Valid from busA
            busB_valid,  // Valid from busB
            busC_valid,  // Valid from busC
            busD_valid,  // Valid from busD
						

	input	[ADC_RESOLUTION - 1: 0]	busA_sample0,	//12bit adc output on bus A 
	input	[ADC_RESOLUTION - 1: 0]	busA_sample1,   //12bit adc output on bus A
	input	[ADC_RESOLUTION - 1: 0]	busA_sample2,   //12bit adc output on bus A
	input	[ADC_RESOLUTION - 1: 0]	busA_sample3,   //12bit adc output on bus A
	input	[ADC_RESOLUTION - 1: 0]	busA_sample4,   //12bit adc output on bus A
	input	[ADC_RESOLUTION - 1: 0]	busA_sample5,   //12bit adc output on bus A
	input	[ADC_RESOLUTION - 1: 0]	busA_sample6,   //12bit adc output on bus A
	input	[ADC_RESOLUTION - 1: 0]	busA_sample7,   //12bit adc output on bus A
                                                
	input	[ADC_RESOLUTION - 1: 0]	busB_sample0,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample1,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample2,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample3,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample4,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample5,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample6,   //12bit adc output on bus B
	input	[ADC_RESOLUTION - 1: 0]	busB_sample7,   //12bit adc output on bus B
                                                
	input	[ADC_RESOLUTION - 1: 0]	busC_sample0,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample1,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample2,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample3,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample4,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample5,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample6,   //12bit adc output on bus C
	input	[ADC_RESOLUTION - 1: 0]	busC_sample7,   //12bit adc output on bus C
                                                
	input	[ADC_RESOLUTION - 1: 0]	busD_sample0,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample1,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample2,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample3,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample4,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample5,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample6,   //12bit adc output on bus D
	input	[ADC_RESOLUTION - 1: 0]	busD_sample7,   //12bit adc output on bus D
	
	output and_of_all_busdata
    );
	
	wire and_of_busA,
	     and_of_busB,
	     and_of_busC,
	     and_of_busD;
	     
	wire and_of_data_busA,
	     and_of_data_busB,
	     and_of_data_busC,
	     and_of_data_busD;
	
	wire and_of_strb_busA,
	     and_of_strb_busB,
	     and_of_strb_busC,
	     and_of_strb_busD;	
	
	assign  and_of_data_busA = |(busA_sample0 | busA_sample1 | busA_sample2 | busA_sample3 | busA_sample4 | busA_sample5 | busA_sample6 | busA_sample7);
	assign  and_of_data_busB = |(busB_sample0 | busB_sample1 | busB_sample2 | busB_sample3 | busB_sample4 | busB_sample5 | busB_sample6 | busB_sample7);
	assign  and_of_data_busC = |(busC_sample0 | busC_sample1 | busC_sample2 | busC_sample3 | busC_sample4 | busC_sample5 | busC_sample6 | busC_sample7);
	assign  and_of_data_busD = |(busD_sample0 | busD_sample1 | busD_sample2 | busD_sample3 | busD_sample4 | busD_sample5 | busD_sample6 | busD_sample7);
	        
	assign	and_of_strb_busA	= | busA_strb ;
	assign	and_of_strb_busB	= | busB_strb ;
	assign	and_of_strb_busC	= | busC_strb ;
	assign	and_of_strb_busD	= | busD_strb ;
	
	assign	and_of_busA	=  and_of_data_busA | and_of_strb_busA | busA_valid;
	assign	and_of_busB =  and_of_data_busB | and_of_strb_busB | busA_valid; 
	assign	and_of_busC =  and_of_data_busC | and_of_strb_busC | busA_valid; 
	assign	and_of_busD =  and_of_data_busD | and_of_strb_busD | busA_valid; 
	
	assign and_of_all_busdata  =   and_of_busA | and_of_busB | and_of_busC | and_of_busD;

endmodule
