`timescale 1ns / 1ps
module MEMORY_ACCESS(
    input clk,
    input [31:0] ADDRESS_MEMORY_ACCESS,
    input [31:0] READ_DATA_2_ACCESS,
    input MEM_WRITE_ACCESS,
    input MEM_READ_ACCESS,
    input MEM_TO_REG_ACCESS,
    output [31:0] OUT_MUX_ACCESS
    );

    wire [31:0] OUT_MEMORY_TO_MUX;

    dataMemory_behavioral DATA_MEMORY(
        .clk(clk),
        .ADDRESS_MEMORY(ADDRESS_MEMORY_ACCESS),
        .READ_DATA_2_MEMORY(READ_DATA_2_ACCESS),
        .MEM_WRITE(MEM_WRITE_ACCESS),
        .MEM_READ(MEM_READ_ACCESS),
        .READ_DATA_OUT(OUT_MEMORY_TO_MUX)
    );

    dataMux_behavioral DATA_MUX(
        .MEM_TO_REG_MUX(MEM_TO_REG_ACCESS),
        .ALU_TO_MUX(ADDRESS_MEMORY_ACCESS), 
        .DATA_TO_MUX(OUT_MEMORY_TO_MUX),
        .RE_WRITE_DATA(OUT_MUX_ACCESS)
    );

endmodule