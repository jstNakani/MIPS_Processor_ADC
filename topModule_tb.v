`timescale 1ns / 1ps

module topModule_tb;

    // Inputs
    reg clk;

    // Outputs
    wire [31:0] DUMMY_BUFF;

    // Instantiate the Unit Under Test (UUT)
    topModule uut (
        .clk(clk), 
        .DUMMY_BUFF(DUMMY_BUFF)
    );

    initial begin
        // Initialize Inputs
        clk = 0;

        // Wait for global reset to finish
        #10;
        

    end
    
    // Generate Clock (Period = 10ns)
    always begin
        #5 clk = ~clk;
    end
      
endmodule