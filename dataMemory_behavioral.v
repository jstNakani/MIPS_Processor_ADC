`timescale 1ns / 1ps
module dataMemory_behavioral(
    input clk,
    input [31:0] ADDRESS_MEMORY,
    input [31:0] READ_DATA_2_MEMORY,
    input MEM_WRITE,
    input MEM_READ,
    output [31:0] READ_DATA_OUT
    );
    
    reg [31:0] MEMORY [0:255];
	 
	 initial begin
	    $readmemb("DATA_ACCESS.txt", MEMORY);
	 end

    always @(posedge clk) begin
        if (MEM_WRITE) begin
            MEMORY[ADDRESS_MEMORY] <= READ_DATA_2_MEMORY;
        end
    end

    assign READ_DATA_OUT = (MEM_READ) ? MEMORY[ADDRESS_MEMORY] : 32'd0;
endmodule
