module top_module(
    input clk,
    input reset,
    input [7:0] packet_loss,
    input [7:0] data_in,

    output [7:0] adaptive_out,
    output [7:0] baseline_out,
    output [15:0] toggle_adaptive,
    output [15:0] toggle_baseline
);

wire [1:0] network_state;
wire tx_enable;

// Instantiate modules

qos_analyzer qos (
    .packet_loss(packet_loss),
    .network_state(network_state)
);

fsm_controller fsm (
    .clk(clk),
    .reset(reset),
    .network_state(network_state),
    .tx_enable(tx_enable)
);

adaptive_tx atx (
    .clk(clk),
    .reset(reset),
    .tx_enable(tx_enable),
    .data_in(data_in),
    .tx_out(adaptive_out)
);

baseline_tx btx (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .tx_out(baseline_out)
);

toggle_counter tc1 (
    .clk(clk),
    .reset(reset),
    .signal_in(adaptive_out),
    .toggle_count(toggle_adaptive)
);

toggle_counter tc2 (
    .clk(clk),
    .reset(reset),
    .signal_in(baseline_out),
    .toggle_count(toggle_baseline)
);

endmodule
