module adaptive_tx(
    input clk,
    input reset,
    input tx_enable,
    input [7:0] data_in,
    output reg [7:0] tx_out
);

always @(posedge clk or posedge reset) begin
    if (reset)
        tx_out <= 8'd0;
    else if (tx_enable)
        tx_out <= data_in;
    else
        tx_out <= tx_out;  // hold value (no switching)
end

endmodule
