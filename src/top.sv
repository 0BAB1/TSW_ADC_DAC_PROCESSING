/* TSW Test top module
*
*  BRH 09/2025
*/

module top_tsw_test (
    input wire clk_p, input wire clk_n,
    // LVDS input pairs
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
    input  wire LRX47_P, input wire LRX47_N
);

    //======================================================
    // Internal single-ended wires after LVDS buffers
    //======================================================
    wire [47:0] lrx_data;
    logic [11:0] channel_a;
    logic [11:0] channel_b;
    logic [11:0] channel_c;
    logic [11:0] channel_d;
    
    always_comb begin : channel_assignements
        channel_a = lrx_data[11:0];
        channel_b = lrx_data[23:12];
        channel_c = lrx_data[35:24];
        channel_d = lrx_data[47:36];
    end

    //======================================================
    // IBUFDS instances for each LVDS pair
    //======================================================

    
    IBUFGDS #(
        .DIFF_TERM("TRUE"),
        .IBUF_LOW_PWR("FALSE")
    ) clk_ibufds (
        .I(clk_p),
        .IB(clk_n),
        .O(clk)
    );

    genvar i;
    generate
        for (i = 0; i < 48; i = i + 1) begin : gen_ibufds
            IBUFDS #(
                .DIFF_TERM("TRUE"),
                .IBUF_LOW_PWR("FALSE")
            ) ibufds_inst (
                .I  ( {LRX0_P, LRX1_P, LRX2_P, LRX3_P, LRX4_P, LRX5_P,
                       LRX6_P, LRX7_P, LRX8_P, LRX9_P, LRX10_P, LRX11_P,
                       LRX12_P, LRX13_P, LRX14_P, LRX15_P, LRX16_P, LRX17_P,
                       LRX18_P, LRX19_P, LRX20_P, LRX21_P, LRX22_P, LRX23_P,
                       LRX24_P, LRX25_P, LRX26_P, LRX27_P, LRX28_P, LRX29_P,
                       LRX30_P, LRX31_P, LRX32_P, LRX33_P, LRX34_P, LRX35_P,
                       LRX36_P, LRX37_P, LRX38_P, LRX39_P, LRX40_P, LRX41_P,
                       LRX42_P, LRX43_P, LRX44_P, LRX45_P, LRX46_P, LRX47_P }[i] ),
                .IB ( {LRX0_N, LRX1_N, LRX2_N, LRX3_N, LRX4_N, LRX5_N,
                       LRX6_N, LRX7_N, LRX8_N, LRX9_N, LRX10_N, LRX11_N,
                       LRX12_N, LRX13_N, LRX14_N, LRX15_N, LRX16_N, LRX17_N,
                       LRX18_N, LRX19_N, LRX20_N, LRX21_N, LRX22_N, LRX23_N,
                       LRX24_N, LRX25_N, LRX26_N, LRX27_N, LRX28_N, LRX29_N,
                       LRX30_N, LRX31_N, LRX32_N, LRX33_N, LRX34_N, LRX35_N,
                       LRX36_N, LRX37_N, LRX38_N, LRX39_N, LRX40_N, LRX41_N,
                       LRX42_N, LRX43_N, LRX44_N, LRX45_N, LRX46_N, LRX47_N }[i] ),
                .O  (lrx_data[i])
            );
        end
    endgenerate

    //======================================================
    // ILA instantiation
    //======================================================
    ila_0 u_ila (
        .clk(clk),
        .probe0(channel_a),
        .probe1(channel_b),
        .probe2(channel_c),
        .probe3(channel_d)
    );

endmodule
