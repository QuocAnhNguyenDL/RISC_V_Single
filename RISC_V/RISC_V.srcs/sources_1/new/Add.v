`timescale 1ns / 1ps

module Add(
    input [31:0] A,B,
    output [31:0] Sum
    );
    
    assign Sum = A + B;
endmodule
