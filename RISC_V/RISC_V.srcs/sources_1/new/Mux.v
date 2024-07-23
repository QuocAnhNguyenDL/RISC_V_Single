`timescale 1ns / 1ps

module Mux(
    input [31:0]  A,B,
    input M,
    output [31:0] Y
    );
    
    assign Y = (M == 1) ? A : B;
    
endmodule
