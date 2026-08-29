module toggle_counter(
    input clk,
    input reset,
    input [7:0] signal_in,
    output reg [15:0] toggle_count
);

reg [7:0] prev;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        toggle_count <= 0;
        prev <= 0;
    end else begin
        toggle_count <= toggle_count + (signal_in ^ prev);
        prev <= signal_in;
    end
end

endmodule
