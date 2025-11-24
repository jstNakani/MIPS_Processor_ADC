`timescale 1ns / 1ps
module dataMux_behavioral(
    input MEM_TO_REG_MUX,
    input [31:0] DATA_TO_MUX,
    input [31:0] ALU_TO_MUX,
    output reg [31:0] RE_WRITE_DATA
    );

    always @(*) begin
        if (MEM_TO_REG_MUX == 1'b1) begin
        RE_WRITE_DATA = DATA_TO_MUX;
        end else begin
            RE_WRITE_DATA = ALU_TO_MUX;
        end
    end

endmodule
