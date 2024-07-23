`timescale 1ns / 1ps

module Imm_Gen(
    input [31:0] Ins,
    output reg[31:0] Imm
    );
    
    always @(*)
    begin
        case (Ins[6:0])
            7'b0010011 : 
            begin
                if(Ins[14:12] == 3'b001 | Ins[14:12] == 3'b101) Imm = {{27{Ins[31]}}, Ins[24:20]}; //I_type (slli)
                else Imm = {{21{Ins[31]}}, Ins[30:20]}; //I_type (addi)
            end
            7'b0000011 : Imm = {{21{Ins[31]}}, Ins[30:20]}; //I_type (lw)
            7'b1100111 : Imm = {{21{Ins[31]}}, Ins[30:20]}; //I_type (jalr)
            7'b0100011 : Imm = {{21{Ins[31]}}, Ins[30:25],Ins[11:7]}; //S_type
            7'b1100011 : Imm = {{20{Ins[31]}}, Ins[7], Ins[30:25], Ins[11:8], 1'b0}; //B_type
            7'b0110111 : Imm = {Ins[31:12], 12'b0}; //LUI
            7'b0010111 : Imm = {Ins[31:12], 12'b0}; //LUI
            7'b1101111 : Imm = {{12{Ins[31]}}, Ins[19:12], Ins[20], Ins[30:25], Ins[24:21], 1'b0}; //J_type
            default : Imm = 32'bx;
        endcase
    end
endmodule
