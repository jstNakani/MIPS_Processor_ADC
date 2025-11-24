`timescale 1ns / 1ps
module signalExtend_behavioral(
		input [15:0] UNEXTENDED,
		output [31:0] EXTENDED
    );

	assign EXTENDED = {{16{UNEXTENDED[15]}}, UNEXTENDED};

endmodule
