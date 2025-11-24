`timescale 1ns / 1ps
module WRITE_BACK(
    input [31:0] EXTENDED_UNSHIFT_TOP,
    input [7:0] PC_COUNTER_ADDR_TOP,
    input BRANCH_TOP,
    input ZERO_CONDITION_TOP,
    output [7:0] JUMP,
    output BRANCH_DECISION
    );

    //SHIFT LEFT
    wire [31:0] SHIFTED_TWO;

    //ADDRR
    wire [7:0] ADDED_PC_COUNTER;

    shiftLeft_behavioral SHIFT_LEFT_TWO(
        .EXTENDED_UNSHIFT(EXTENDED_UNSHIFT_TOP),
        .EXTENDED_SHIFTED(SHIFTED_TWO)
    );

    jumperAddr_behavioral JUMPER_ADDR(
        .EXTENDED_ADDR(SHIFTED_TWO),
        .PC_COUNTER_ADDR(PC_COUNTER_ADDR_TOP),
        .PC_COUNTER_ADDR_OUT(JUMP)
    );

    assign BRANCH_DECISION = BRANCH_TOP & ZERO_CONDITION_TOP;

endmodule
