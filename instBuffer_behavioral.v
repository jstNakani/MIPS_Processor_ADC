`timescale 1ns / 1ps
module instBuffer_behavioral(
    input clk,
    input [31:0] DATA_IN,
    input [7:0] PC_COUNTER_FIRST_IN,
    output reg [31:0] DATA_OUT,
    output reg [7:0] PC_COUNTER_FIRST_OUT
    );

	always@(posedge clk) begin
		DATA_OUT <= DATA_IN;
        PC_COUNTER_FIRST_OUT <= PC_COUNTER_FIRST_IN;
	end

endmodule
