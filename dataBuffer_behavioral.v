`timescale 1ns / 1ps
module dataBuffer_behavioral(
    input clk,
    
    // Data Path
    input [31:0] VALUE_BUFFER_IN,
    input [31:0] READ_DATA_2_IN,
    input [4:0] DEST_ADDR_IN,
    
    // Control Signals
    input MEM_WRITE_ACCESS_BUFF,
    input MEM_READ_ACCESS_BUFF,
    input MEM_TO_REG_ACCESS_BUFF,
    input REG_WRITE_BUFF,
    
    // Outputs
    output reg [31:0] VALUE_BUFFER_OUT,
    output reg [31:0] READ_DATA_2_OUT,
    output reg [4:0] DEST_ADDR_OUT,
    
    output reg MEM_WRITE_ACCESS_BUFF_OUT,
    output reg MEM_READ_ACCESS_BUFF_OUT,
    output reg MEM_TO_REG_ACCESS_BUFF_OUT,
    output reg REG_WRITE_BUFF_OUT
    );

    always @(posedge clk) begin
        VALUE_BUFFER_OUT <= VALUE_BUFFER_IN;
        READ_DATA_2_OUT <= READ_DATA_2_IN;
        DEST_ADDR_OUT <= DEST_ADDR_IN;
        
        MEM_WRITE_ACCESS_BUFF_OUT <= MEM_WRITE_ACCESS_BUFF;
        MEM_READ_ACCESS_BUFF_OUT <= MEM_READ_ACCESS_BUFF;
        MEM_TO_REG_ACCESS_BUFF_OUT <= MEM_TO_REG_ACCESS_BUFF;
        REG_WRITE_BUFF_OUT <= REG_WRITE_BUFF;
    end
endmodule