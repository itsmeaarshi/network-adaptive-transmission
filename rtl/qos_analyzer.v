module qos_analyzer(
    input [7:0] packet_loss,   // 0–100%
    output reg [1:0] network_state
);

// State encoding
// 00 → GOOD
// 01 → MODERATE
// 10 → POOR

always @(*) begin
    if (packet_loss < 8'd5)
        network_state = 2'b00;   // GOOD
    else if (packet_loss < 8'd20)
        network_state = 2'b01;   // MODERATE
    else
        network_state = 2'b10;   // POOR
end

endmodule
