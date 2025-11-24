`timescale 1ns / 1ps
module DECODE(
    input clk,
    input [14:0] FULL_DATA,
    input REG_WRITE_DECODE,
    input REG_DST_DECODE,
	 
    input [31:0] DATA_IN_FROM_MEMORY,
    input [4:0] WRITE_ADDR_FROM_WB,
    
    // Outputs
    output [31:0] DATA_READ_1,
    output [31:0] DATA_READ_2,
    output [4:0] CHOSEN_DEST_ADDR
    );
     
     // Wires
     wire [4:0] READ_REGISTER_1;
     wire [4:0] READ_REGISTER_2;
     wire [4:0] WRITE_REGISTER_CANDIDATE;
     
     regMem_behavioral REG_MEM(
        .clk(clk),
        .AR_1(READ_REGISTER_1),
        .AR_2(READ_REGISTER_2),
        .AW(WRITE_ADDR_FROM_WB), 
        .DATA_IN(DATA_IN_FROM_MEMORY),
        .WE(REG_WRITE_DECODE),
        .DR_1(DATA_READ_1),
        .DR_2(DATA_READ_2)
     );
     
     instMux_behavioral MUX(
        .CTRL(REG_DST_DECODE),
        .RT_IN(READ_REGISTER_2),
        .RD_IN(WRITE_REGISTER_CANDIDATE),
        .AW(CHOSEN_DEST_ADDR) 
     );
     
     assign READ_REGISTER_1 = FULL_DATA[14:10];
     assign READ_REGISTER_2 = FULL_DATA[9:5];
     assign WRITE_REGISTER_CANDIDATE = FULL_DATA[4:0];
     
endmodule