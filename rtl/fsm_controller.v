module fsm_controller(
    input clk,
    input reset,
    input [1:0] network_state,
    output reg tx_enable
);

reg [1:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        tx_enable <= 0;
        counter <= 0;
    end else begin
        case (network_state)

            2'b00: begin  // GOOD
                tx_enable <= 1;
            end

            2'b01: begin  // MODERATE
                counter <= counter + 1;
                if (counter == 2'd1)
                    tx_enable <= 1;
                else
                    tx_enable <= 0;
            end

            2'b10: begin  // POOR
                tx_enable <= 0;
            end

            default: tx_enable <= 0;

        endcase
    end
end

endmodule
