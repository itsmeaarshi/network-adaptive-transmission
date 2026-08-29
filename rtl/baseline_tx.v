module baseline_tx(
    input clk,
    input reset,
    input [7:0] data_in,
    output reg [7:0] tx_out
);

always @(posedge clk or posedge reset) begin
    if (reset)
        tx_out <= 8'd0;
    else
        tx_out <= data_in;  // always transmitting
end

endmodule
