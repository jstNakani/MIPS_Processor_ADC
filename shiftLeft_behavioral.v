`timescale 1ns / 1ps
module shiftLeft_behavioral(
    input [31:0] EXTENDED_UNSHIFT,
    output [31:0] EXTENDED_SHIFTED
    );

    assign EXTENDED_SHIFTED = EXTENDED_UNSHIFT << 2;

endmodule
