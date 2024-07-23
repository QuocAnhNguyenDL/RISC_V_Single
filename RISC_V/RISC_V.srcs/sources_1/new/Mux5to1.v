`timescale 1ns / 1ps

module Mux5to1(
    input [31:0] A,B,C,D,E,
    input [2:0] M,
    output [31:0] Y
    );
    
    assign Y = (M == 3'b000) ? A : 
               (M == 3'b001) ? B :
               (M == 3'b010) ? C :
               (M == 3'b011) ? D :
               (M == 3'b100) ? E : 3'b000;
                    
endmodule
