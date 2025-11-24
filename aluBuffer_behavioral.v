`timescale 1ns / 1ps
module aluBuffer_behavioral(
    input clk,
    
    // Data Inputs
    input [31:0] DATA_IN_1,
    input [31:0] DATA_IN_2,
    input [31:0] EXTENDED_IN,
    input [4:0] DEST_ADDR_IN,
    input [7:0] PC_COUNTER_SECOND_IN,
    
    // Control Inputs
    input BRANCH_BUFF,
    input MEM_READ_BUFF,
    input MEM_TO_REG_BUFF,
    input [1:0] ALU_OP_BUFF,
    input MEM_WRITE_BUFF,
    input ALU_SRC_BUFF,
    input REG_WRITE_BUFF,

    // Outputs
    output reg [31:0] DATA_OUT_1,
    output reg [31:0] DATA_OUT_2,
    output reg [31:0] EXTENDED_OUT,
    output reg [4:0] DEST_ADDR_OUT,
    
    output reg BRANCH_BUFF_OUT,
    output reg MEM_READ_BUFF_OUT,
    output reg MEM_TO_REG_BUFF_OUT,
    output reg [1:0] ALU_OP_BUFF_OUT,
    output reg MEM_WRITE_BUFF_OUT,
    output reg ALU_SRC_BUFF_OUT,
    output reg REG_WRITE_BUFF_OUT,
    output reg [7:0] PC_COUNTER_SECOND_OUT
    );

    always@(posedge clk) begin
        DATA_OUT_1 <= DATA_IN_1;
        DATA_OUT_2 <= DATA_IN_2;
        EXTENDED_OUT <= EXTENDED_IN;
        DEST_ADDR_OUT <= DEST_ADDR_IN;
        PC_COUNTER_SECOND_OUT <= PC_COUNTER_SECOND_IN;
        
        BRANCH_BUFF_OUT <= BRANCH_BUFF;
        MEM_READ_BUFF_OUT <= MEM_READ_BUFF;
        MEM_TO_REG_BUFF_OUT <= MEM_TO_REG_BUFF;
        ALU_OP_BUFF_OUT <= ALU_OP_BUFF;
        MEM_WRITE_BUFF_OUT <= MEM_WRITE_BUFF;
        ALU_SRC_BUFF_OUT <= ALU_SRC_BUFF;
        REG_WRITE_BUFF_OUT <= REG_WRITE_BUFF;
    end

endmodule