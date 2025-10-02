/* LVDS CLK CONV
*
*  converts LVDS clock to single ended signal usin
*  XILINX IBUFGDS primitive.
*
*  BRH 09/25
*/

module lvds_clk_conv (
    input wire clk_p, input wire clk_n,
    output wire clk_out
);

    IBUFGDS #(
        .DIFF_TERM("TRUE"),
        .IBUF_LOW_PWR("FALSE")
    ) IBUFGDS_RXCLK (
        .I(clk_p), .IB(clk_n),
        .O(clk_out)
    );

endmodule