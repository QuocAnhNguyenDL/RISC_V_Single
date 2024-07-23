`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2024 09:42:53 PM
// Design Name: 
// Module Name: PC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC(
    input clk,
    input reset,
    input [31:0] PC_in,
    output reg[31:0] PC_out
    );
    
    always @(negedge clk)
    begin
        PC_out <= PC_in;
    end
    
    always @(posedge reset)
    begin
        PC_out = 32'b0;
    end
endmodule
