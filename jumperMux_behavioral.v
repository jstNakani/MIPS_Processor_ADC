`timescale 1ns / 1ps
module jumperMux_behavioral(
    input MUX_CONTROL_BRANCH,
    input [7:0] ORIGINAL_ADDR,
    input [7:0] BRANCH_ADDR,
    output reg [7:0] COUNTER_OUT_BRANCH
    );

    always @(*) begin
        if (MUX_CONTROL_BRANCH) begin
            COUNTER_OUT_BRANCH = BRANCH_ADDR;
        end else begin
          COUNTER_OUT_BRANCH = ORIGINAL_ADDR;
        end
    end

endmodule
