/* TSW Test top module
*
*  BRH 09/2025
*/

module sampler (
    // Input sys clock
    input wire sys_clk,

    // ADC Channels DDR clocks
    input wire ddr_clk0,
    input wire ddr_clk1,
    input wire ddr_clk2,
    input wire ddr_clk3,

    // ADC Channels strobes
    input wire RX_STROBE0_P, input wire RX_STROBE0_N,
    input wire RX_STROBE1_P, input wire RX_STROBE1_N,
    input wire RX_STROBE2_P, input wire RX_STROBE2_N,
    input wire RX_STROBE3_P, input wire RX_STROBE3_N,

    // ===================
    // LVDS input pairs
    // ===================

    // CH A
    input  wire LRX0_P,  input wire LRX0_N,
    input  wire LRX1_P,  input wire LRX1_N,
    input  wire LRX2_P,  input wire LRX2_N,
    input  wire LRX3_P,  input wire LRX3_N,
    input  wire LRX4_P,  input wire LRX4_N,
    input  wire LRX5_P,  input wire LRX5_N,
    input  wire LRX6_P,  input wire LRX6_N,
    input  wire LRX7_P,  input wire LRX7_N,
    input  wire LRX8_P,  input wire LRX8_N,
    input  wire LRX9_P,  input wire LRX9_N,
    input  wire LRX10_P, input wire LRX10_N,
    input  wire LRX11_P, input wire LRX11_N,

    // CH B
    input  wire LRX12_P, input wire LRX12_N,
    input  wire LRX13_P, input wire LRX13_N,
    input  wire LRX14_P, input wire LRX14_N,
    input  wire LRX15_P, input wire LRX15_N,
    input  wire LRX16_P, input wire LRX16_N,
    input  wire LRX17_P, input wire LRX17_N,
    input  wire LRX18_P, input wire LRX18_N,
    input  wire LRX19_P, input wire LRX19_N,
    input  wire LRX20_P, input wire LRX20_N,
    input  wire LRX21_P, input wire LRX21_N,
    input  wire LRX22_P, input wire LRX22_N,
    input  wire LRX23_P, input wire LRX23_N,

    // CH C
    input  wire LRX24_P, input wire LRX24_N,
    input  wire LRX25_P, input wire LRX25_N,
    input  wire LRX26_P, input wire LRX26_N,
    input  wire LRX27_P, input wire LRX27_N,
    input  wire LRX28_P, input wire LRX28_N,
    input  wire LRX29_P, input wire LRX29_N,
    input  wire LRX30_P, input wire LRX30_N,
    input  wire LRX31_P, input wire LRX31_N,
    input  wire LRX32_P, input wire LRX32_N,
    input  wire LRX33_P, input wire LRX33_N,
    input  wire LRX34_P, input wire LRX34_N,
    input  wire LRX35_P, input wire LRX35_N,

    // CH D
    input  wire LRX36_P, input wire LRX36_N,
    input  wire LRX37_P, input wire LRX37_N,
    input  wire LRX38_P, input wire LRX38_N,
    input  wire LRX39_P, input wire LRX39_N,
    input  wire LRX40_P, input wire LRX40_N,
    input  wire LRX41_P, input wire LRX41_N,
    input  wire LRX42_P, input wire LRX42_N,
    input  wire LRX43_P, input wire LRX43_N,
    input  wire LRX44_P, input wire LRX44_N,
    input  wire LRX45_P, input wire LRX45_N,
    input  wire LRX46_P, input wire LRX46_N,
    input  wire LRX47_P, input wire LRX47_N,

    // data out, sampled at main clk speed
    output wire [11:0] data_out
);

    // ========================
    // Channel A capture
    // ========================

    // Get bus A LVDS 12 input bits
    wire [11:0] lrx_a_ibuf;
    wire [11:0] lrx_a_ibuf_p = {
        LRX0_P,
        LRX1_P,
        LRX2_P,
        LRX3_P,
        LRX4_P,
        LRX5_P,
        LRX6_P,
        LRX7_P,
        LRX8_P,
        LRX9_P,
        LRX10_P,
        LRX11_P
    };
    wire [11:0] lrx_a_ibuf_n = {
        LRX0_N,
        LRX1_N,
        LRX2_N,
        LRX3_N,
        LRX4_N,
        LRX5_N,
        LRX6_N,
        LRX7_N,
        LRX8_N,
        LRX9_N,
        LRX10_N,
        LRX11_N
    };
    genvar i;
    generate
        for (i = 0; i < 12; i=i+1) begin
            IBUFDS #(
                .DIFF_TERM("TRUE"),
                .IBUF_LOW_PWR("FALSE")
            ) IBUFDS_RX_inst (
                .I(lrx_a_ibuf_p[i]),
                .IB(lrx_a_ibuf_n[i]),
                .O(lrx_a_ibuf[i])
            );
        end
    endgenerate

    // capture bus A input bits as DDR @ 800MHz
    wire [11:0] lrx_a_q1, lrx_a_q2;

    genvar j;
    generate
        for (j = 0; j < 12; j=j+1) begin
            IDDRE1 #(
                .DDR_CLK_EDGE("SAME_EDGE")
            ) IDDR_LRX_inst (
                // sample N
                .Q1(lrx_a_q1[j]),
                // sample N + 1
                .Q2(lrx_a_q2[j]),

                .C(ddr_clk0),
                // .CB(~rx_clk_ibuf),
                .D(lrx_a_ibuf[j]),
                .R(1'b0)
            );
        end
    endgenerate
    
    
    reg [11:0] lrx_a_sync1, lrx_a_sync2;

    always @(posedge sys_clk) begin
        lrx_a_sync1 <= lrx_a_q1;
        lrx_a_sync2 <= lrx_a_sync1;
    end

    assign data_out = lrx_a_sync2;

endmodule
