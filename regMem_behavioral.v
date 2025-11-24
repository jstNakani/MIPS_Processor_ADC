`timescale 1ns / 1ps
module regMem_behavioral(
    input clk,
    input [4:0] AR_1,
    input [4:0] AR_2,
    input [4:0] AW,
    input [31:0] DATA_IN,
    input WE,
    output [31:0] DR_1,
    output [31:0] DR_2
);

    reg [31:0] REG_BANK [0:31];

    initial begin
        $readmemb("REG_DATA.txt", REG_BANK);
    end
	 
    always @(posedge clk) begin
        if (WE && (AW != 5'd0)) begin
             REG_BANK[AW] <= DATA_IN; 
        end
    end

    assign DR_1 = (AR_1 == 5'd0) ? 32'd0 : REG_BANK[AR_1];
    assign DR_2 = (AR_2 == 5'd0) ? 32'd0 : REG_BANK[AR_2];
endmodule