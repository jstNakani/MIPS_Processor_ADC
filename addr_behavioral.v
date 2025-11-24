`timescale 1ns / 1ps
module addr_behavioral (
    input [7:0] ADDRESS_IN,
    output reg [7:0] ADDRESS_OUT
);

    always @(*) begin
        ADDRESS_OUT = ADDRESS_IN + 4;
    end

endmodule
