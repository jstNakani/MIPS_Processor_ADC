`timescale 1ns / 1ps
module memRollBackBuffer_behavioral(
    input clk,
    input [31:0] MEMORY_TO_BUFFER,
    input [4:0] DEST_ADDR_IN,
    input REG_WRITE_IN,

    output reg [31:0] MEMORY_TO_REG,
    output reg [4:0] DEST_ADDR_OUT,
    output reg REG_WRITE_OUT
    );

    always @(posedge clk) begin
        MEMORY_TO_REG <= MEMORY_TO_BUFFER;
        DEST_ADDR_OUT <= DEST_ADDR_IN;
        REG_WRITE_OUT <= REG_WRITE_IN;
    end

endmodule