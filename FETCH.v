`timescale 1ns / 1ps
module FETCH(
		input clk,
		input [7:0] PC_JUMPER,
		input PC_JUMP_FLAG,
		output [31:0] FETCH_OUT,
		output [7:0] PC_COUNTER_OUT
    );

	//PC
	wire [7:0] ADDRESS_OUT_PC;
	//INST_MEM
	wire [31:0] DATA_OUT_MEM_INST;
	
	PC_behavioral PC(
		.clk(clk),
		.JUMPER(PC_JUMPER),
		.JUMP_ENABLE(PC_JUMP_FLAG),
		.ADDRESS_OUT(ADDRESS_OUT_PC)
	);
	
	memInst_behavioral INST_MEM(
		.ADDRESS(ADDRESS_OUT_PC),
		.DATA_OUT(DATA_OUT_MEM_INST)
	);
	
	assign PC_COUNTER_OUT = ADDRESS_OUT_PC;
	assign FETCH_OUT = DATA_OUT_MEM_INST;

endmodule
