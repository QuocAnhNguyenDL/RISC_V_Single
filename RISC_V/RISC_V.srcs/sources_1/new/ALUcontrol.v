`timescale 1ns / 1ps

module ALUcontrol(
        input [1:0] ALUop,
        input Ins30,
        input [2:0] Ins14_12,
        output reg [3:0] Control_Signal
    );
    
    `include "Para.v"
    
    always @(ALUop, Ins30, Ins14_12)
    begin
        case ({ALUop, Ins14_12})
            {2'b00, 3'b000} : Control_Signal = ADD;
            {2'b00, 3'b001} : Control_Signal = ADD;
            {2'b00, 3'b010} : Control_Signal = ADD;
            {2'b00, 3'b100} : Control_Signal = ADD;
            {2'b00, 3'b101} : Control_Signal = ADD;
            
            
            {2'b01, 3'b000} : Control_Signal = (Ins30 == 1'b0) ? ADD : SUB;
            {2'b01, 3'b100} : Control_Signal = XOR;
            {2'b01, 3'b110} : Control_Signal = OR;
            {2'b01, 3'b111} : Control_Signal = AND;
            {2'b01, 3'b001} : Control_Signal = SLL;
            {2'b01, 3'b101} : Control_Signal = (Ins30 == 1'b0) ? SRL : SRA;
            {2'b01, 3'b010} : Control_Signal = SLT;
            {2'b01, 3'b011} : Control_Signal = SLTU;
            
            {2'b10, 3'b000} : Control_Signal = ADD;
            {2'b10, 3'b100} : Control_Signal = XOR;
            {2'b10, 3'b110} : Control_Signal = OR;
            {2'b10, 3'b111} : Control_Signal = AND;
            {2'b10, 3'b001} : Control_Signal = SLL;
            {2'b10, 3'b101} : Control_Signal = (Ins30 == 1'b0) ? SRL : SRA;
            {2'b10, 3'b010} : Control_Signal = SLT;
            {2'b10, 3'b011} : Control_Signal = SLTU;
            
            {2'b11, 3'b000} : Control_Signal = EQUAL;
            {2'b11, 3'b001} : Control_Signal = NEQUAL;
            {2'b11, 3'b100} : Control_Signal = LESS;
            {2'b11, 3'b101} : Control_Signal = GREATERorEQUAL;
            {2'b11, 3'b110} : Control_Signal = LESS_U;
            {2'b11, 3'b111} : Control_Signal = GREATERorEQUAL_U;
            
            default : Control_Signal = 4'bxxxx;
        endcase
    end
    
endmodule
