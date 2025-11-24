`timescale 1ns / 1ps
module alu_behavioral(
    input [3:0] ALU_CONTROL_INSIDE,
    input [31:0] REG_DATA_1_INSIDE,
    input [31:0] MUX_INPUT,
    input [1:0] OP_CODE_INSIDE,
    output reg [31:0] ALU_OUT_TO_MEM,
    output reg ALU_ZERO_CONDITION
    );

    always @* begin
        ALU_ZERO_CONDITION = 1'b0; 
        ALU_OUT_TO_MEM = 32'd0;

        if (ALU_CONTROL_INSIDE == 4'b0010) begin
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE + MUX_INPUT;
            ALU_ZERO_CONDITION = 1'b0;
        end else if (ALU_CONTROL_INSIDE == 4'b0110) begin
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE - MUX_INPUT;

            if (OP_CODE_INSIDE == 2'b01) begin
                ALU_ZERO_CONDITION = 1'b1;
            end else begin
                ALU_ZERO_CONDITION = 1'b0;
            end
        end else if (ALU_CONTROL_INSIDE == 4'b0000) begin
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE & MUX_INPUT;
            ALU_ZERO_CONDITION = 1'b0;
        end else if (ALU_CONTROL_INSIDE == 4'b0001) begin
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE | MUX_INPUT;
            ALU_ZERO_CONDITION = 1'b0;
        end else if (ALU_CONTROL_INSIDE == 4'b0111) begin
            if (REG_DATA_1_INSIDE < MUX_INPUT) begin
                ALU_OUT_TO_MEM = 32'd1;
            end else begin
                ALU_OUT_TO_MEM = 32'd0;
            end
            ALU_ZERO_CONDITION = 1'b0;
        end else begin
             ALU_OUT_TO_MEM = 32'd10;
             ALU_ZERO_CONDITION = 1'b0;
        end
    end
endmodule