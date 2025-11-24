`timescale 1ns / 1ps
module PC_behavioral(
    input clk,
    input [7:0] JUMPER,
    input JUMP_ENABLE,
    output [7:0] ADDRESS_OUT
    );

    reg [7:0] PC_REG;
    wire [7:0] ADDR_TO_PC;

    addr_behavioral ADDR (
        .ADDRESS_IN(PC_REG),
        .ADDRESS_OUT(ADDR_TO_PC)
    );

    initial begin
        PC_REG = 8'd0;
    end

    assign ADDRESS_OUT = PC_REG;
    always @(posedge clk) begin
        if (JUMP_ENABLE) begin
          PC_REG <= JUMPER;
        end else begin
            PC_REG <= ADDR_TO_PC;
        end
    end

endmodule