/* TSW Test top module
*
*  BRH 09/2025
*/

module sampler (
    // Input sys clock
    input wire sys_clk,

    // ADC Channels DDR clocks
    input wire [47:0] rx_data_in,
    input wire [3:0] rx_clk_in,
    input wire [3:0] rx_strb_in,
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
    
    // Sample bus A @ 125MHz
    reg [11:0] lrx_a_sync1, lrx_a_sync2;

    always @(posedge sys_clk) begin
        lrx_a_sync1 <= lrx_a_q1;
        lrx_a_sync2 <= lrx_a_sync1;
    end

    assign data_out = lrx_a_sync2;

endmodule
