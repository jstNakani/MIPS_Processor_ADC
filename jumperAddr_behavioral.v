`timescale 1ns / 1ps
module jumperAddr_behavioral(
    input [31:0] EXTENDED_ADDR,
    input [7:0] PC_COUNTER_ADDR,
    output [7:0] PC_COUNTER_ADDR_OUT
    );

    assign PC_COUNTER_ADDR_OUT = EXTENDED_ADDR + PC_COUNTER_ADDR;
	 
endmodule
