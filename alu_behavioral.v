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
        // Defaults
        ALU_ZERO_CONDITION = 1'b0; 
        ALU_OUT_TO_MEM = 32'd0;

        if (ALU_CONTROL_INSIDE == 4'b0010) begin // ADD
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE + MUX_INPUT;
        end else if (ALU_CONTROL_INSIDE == 4'b0110) begin // SUB (BEQ)
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE - MUX_INPUT;
            
            // FIX: Only set Zero Flag if the result is actually zero!
            if (ALU_OUT_TO_MEM == 32'd0) begin
                ALU_ZERO_CONDITION = 1'b1;
            end else begin
                ALU_ZERO_CONDITION = 1'b0;
            end
            
        end else if (ALU_CONTROL_INSIDE == 4'b0000) begin // AND
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE & MUX_INPUT;
        end else if (ALU_CONTROL_INSIDE == 4'b0001) begin // OR
            ALU_OUT_TO_MEM = REG_DATA_1_INSIDE | MUX_INPUT;
        end else if (ALU_CONTROL_INSIDE == 4'b0111) begin // SLT
            if (REG_DATA_1_INSIDE < MUX_INPUT) begin
                ALU_OUT_TO_MEM = 32'd1;
            end else begin
                ALU_OUT_TO_MEM = 32'd0;
            end
        end else begin
             ALU_OUT_TO_MEM = 32'd10;
        end
    end
endmodule