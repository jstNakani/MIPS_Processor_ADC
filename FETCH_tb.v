`timescale 1ns / 1ps
module FETCH_tb;
	reg clk;
	wire [31:0] DUMMY_INST;

	FETCH uut (
		.clk(clk), 
		.DUMMY_INST(DUMMY_INST)
	);
	parameter clk_period = 10;

	initial begin
		clk = 0;
		#100;
		$stop;
	end
      always#(clk_period/2)clk = ~clk;
endmodule

