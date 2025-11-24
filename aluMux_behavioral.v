`timescale 1ns / 1ps
module aluMux_behavioral(
    input ALU_SRC_IN,
    input [31:0] READ_DATA_2_IN,
    input [31:0] EXTENDED_SIGNAL_IN,
    output [31:0] ALU_MUX_OUT
    );

    assign ALU_MUX_OUT = (ALU_SRC_IN == 1'b0) ? READ_DATA_2_IN : EXTENDED_SIGNAL_IN;

endmodule