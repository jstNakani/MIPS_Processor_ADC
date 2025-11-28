`timescale 1ns / 1ps
module memInst_behavioral(
    input [7:0] ADDRESS,
    output [31:0] DATA_OUT
    );

    reg [31:0] REG_INST [0:63];
    
    initial begin
        $readmemb("program.txt", REG_INST);
    end
	 
    assign DATA_OUT = REG_INST[ADDRESS[7:2]];
    
endmodule