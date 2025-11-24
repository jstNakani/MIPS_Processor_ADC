`timescale 1ns / 1ps
module EXECUTE(
    input ALU_SRC_TO_MUX,
    input [31:0] EXTENDED_SIGNAL_TO_MUX,
    input [31:0] REG_DATA_1,
    input [31:0] REG_DATA_TO_MUX_2,
    input [3:0] ALU_CONTROL_IN,
    input [1:0] OP_CODE,
    output ZERO_CONDITION_ALU,
    output [31:0] VALUE_ALU_OUT
    );

    //MUX
    wire [31:0] MUX_OUTPUT_TO_ALU;

    alu_behavioral ALU(
        .ALU_CONTROL_INSIDE(ALU_CONTROL_IN),
        .REG_DATA_1_INSIDE(REG_DATA_1),
        .MUX_INPUT(MUX_OUTPUT_TO_ALU),
        .OP_CODE_INSIDE(OP_CODE),
        .ALU_OUT_TO_MEM(VALUE_ALU_OUT),
        .ALU_ZERO_CONDITION(ZERO_CONDITION_ALU)
    );

    aluMux_behavioral ALU_MUX(
        .ALU_SRC_IN(ALU_SRC_TO_MUX),
        .READ_DATA_2_IN(REG_DATA_TO_MUX_2),
        .EXTENDED_SIGNAL_IN(EXTENDED_SIGNAL_TO_MUX),
        .ALU_MUX_OUT(MUX_OUTPUT_TO_ALU)
    );


endmodule
