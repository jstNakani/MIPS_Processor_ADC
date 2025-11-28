`timescale 1ns / 1ps
module aluControl_beh(
		input [1:0] OP_CONTROL,
		input [5:0] FUNCTION,
		output reg [3:0] ALU_CONTROL_OUT
    );

	always@* begin
		if (OP_CONTROL == 2'b00) begin
			ALU_CONTROL_OUT = 4'b0010;
		end else if (OP_CONTROL == 2'b01) begin
			ALU_CONTROL_OUT = 4'b0110;
		end else if (OP_CONTROL == 2'b10) begin
		
		//R Type begin
			if (FUNCTION == 6'b000000) begin
				ALU_CONTROL_OUT = 4'b0010;
			end else if (FUNCTION == 6'b100000) begin
				ALU_CONTROL_OUT = 4'b0010;
			end else if (FUNCTION == 6'b100010) begin
				ALU_CONTROL_OUT = 4'b0110;
			end else if (FUNCTION == 6'b100100) begin
				ALU_CONTROL_OUT = 4'b0000;
			end else if (FUNCTION == 6'b100101) begin
				ALU_CONTROL_OUT = 4'b0001;
			end else if (FUNCTION == 6'b101010) begin
				ALU_CONTROL_OUT = 4'b0111;				
			//R Type end
				
			end else begin
				ALU_CONTROL_OUT = 4'b1111;
			end
		
		end else begin
			ALU_CONTROL_OUT = 4'b1111;
		end
	end

endmodule
