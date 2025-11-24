module instMux_behavioral(
    input CTRL,
    input [4:0] RT_IN,
    input [4:0] RD_IN,
    output reg [4:0] AW
    );

    always @* begin
        if (CTRL == 1'b0) begin
            AW = RT_IN;
        end else begin
            AW = RD_IN; 
        end
    end
endmodule