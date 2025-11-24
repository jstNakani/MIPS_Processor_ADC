`timescale 1ns / 1ps
module aluControl_behavioral(
		input [5:0] FULL_IN,
		output reg REG_DST, 
		output reg BRANCH, 
		output reg MEM_READ, 
		output reg MEM_TO_REG, 
		output reg MEM_WRITE,
		output reg ALU_SRC, 
		output reg REG_WRITE,
		output reg [1:0] ALU_OP
    );

	always@(FULL_IN) begin
		case(FULL_IN)
		// 000000 = Type R
			6'b000000: begin
				REG_DST = 1'b1;
				ALU_SRC = 1'b0;
				MEM_TO_REG = 1'b0;
				REG_WRITE = 1'b1;
				MEM_READ = 1'b0;
				MEM_WRITE = 1'b0;
				BRANCH = 1'b0;
				ALU_OP = 2'b10;
			end
			// 100011 = LW
			6'b100011: begin
				REG_DST = 1'b0;
				ALU_SRC = 1'b1;
				MEM_TO_REG = 1'b1;
				REG_WRITE = 1'b1;
				MEM_READ = 1'b1;
				MEM_WRITE = 1'b0;
				BRANCH = 1'b0;
				ALU_OP = 2'b00;
			end
			// 101011 = SW
			6'b101011: begin
				REG_DST = 1'b0;
				ALU_SRC = 1'b1;
				MEM_TO_REG = 1'b0;
				REG_WRITE = 1'b0;
				MEM_READ = 1'b0;
				MEM_WRITE = 1'b1;
				BRANCH = 1'b0;
				ALU_OP = 2'b00;
			end
			// 000100 = BEQ
			6'b000100: begin
				REG_DST = 1'b0;
				ALU_SRC = 1'b0;
				MEM_TO_REG = 1'b0;
				REG_WRITE = 1'b0;
				MEM_READ = 1'b0;
				MEM_WRITE = 1'b0;
				BRANCH = 1'b1;
				ALU_OP = 2'b01;
			end
			default: begin
				REG_DST = 1'b0;
				ALU_SRC = 1'b0;
				MEM_TO_REG = 1'b0;
				REG_WRITE = 1'b0;
				MEM_READ = 1'b0;
				MEM_WRITE = 1'b0;
				BRANCH = 1'b0;
				ALU_OP = 2'b00;
			end
	endcase
end


endmodule
