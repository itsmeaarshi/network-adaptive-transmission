`timescale 1ns/1ps
module tb_top;

reg clk;
reg reset;
reg [7:0] packet_loss;
reg [7:0] data_in;

wire [7:0] adaptive_out;
wire [7:0] baseline_out;
wire [15:0] toggle_adaptive;
wire [15:0] toggle_baseline;

top_module uut (
    .clk(clk),
    .reset(reset),
    .packet_loss(packet_loss),
    .data_in(data_in),
    .adaptive_out(adaptive_out),
    .baseline_out(baseline_out),
    .toggle_adaptive(toggle_adaptive),
    .toggle_baseline(toggle_baseline)
);

always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    reset = 1;
    data_in = 0;
    packet_loss = 0;

    // Release reset
    #10 reset = 0;

    $display("---- GOOD NETWORK ----");
    packet_loss = 2;   // GOOD

    repeat(20) begin
        #10 data_in = $random;
    end

    $display("Adaptive Toggles (GOOD): %d", toggle_adaptive);
    $display("Baseline Toggles (GOOD): %d", toggle_baseline);


    $display("---- MODERATE NETWORK ----");
    packet_loss = 10;  // MODERATE

    repeat(20) begin
        #10 data_in = $random;
    end

    $display("Adaptive Toggles (MODERATE): %d", toggle_adaptive);
    $display("Baseline Toggles (MODERATE): %d", toggle_baseline);


    $display("---- POOR NETWORK ----");
    packet_loss = 30;  // POOR

    repeat(20) begin
        #10 data_in = $random;
    end

    $display("Adaptive Toggles (POOR): %d", toggle_adaptive);
    $display("Baseline Toggles (POOR): %d", toggle_baseline);


    // Finish simulation
    #20 $finish;
end

endmodule
