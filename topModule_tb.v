`timescale 1ns / 1ps

module topModule_tb;
    reg clk;
    wire [31:0] DUMMY_BUFF;
    wire [31:0] DUMMY_DATA_READ;
	wire [31:0] DUMMY_ALU_OUT;
    wire [31:0] DUMMY_OUT_FROM_DATA;
    wire DUMMY_WRITE_ENABLE;

    topModule uut (
        .clk(clk), 
        .DUMMY_BUFF(DUMMY_BUFF),
        .DUMMY_DATA_READ(DUMMY_DATA_READ),
        .DUMMY_ALU_OUT(DUMMY_ALU_OUT),
        .DUMMY_OUT_FROM_DATA(DUMMY_OUT_FROM_DATA),
        .DUMMY_WRITE_ENABLE(DUMMY_WRITE_ENABLE)
    );
	 //slash

    initial begin
        clk = 0;
        #10000;
		  $finish;
    end
    always begin
        #5 clk = ~clk;
    end
      
endmodule