`timescale 1ns / 1ps

module ControlUnit(
    input [6:0] Opcode, 
    output reg MemRead, MemWrite, ALUsrc, RegWrite, PCsel,
    output reg [1:0] Branch,
    output reg [1:0] ALUop,
    output reg [2:0] MemtoReg
    );
    
    always @(Opcode)
    begin
        case (Opcode)
            
            //R-tpye
            7'b0110011 : begin
                ALUsrc      = 1'b0;
                MemtoReg    = 3'b001;
                RegWrite    = 1'b1;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b00;
                ALUop       = 2'b01;
                PCsel       = 1'b0;
            end
            
            //I-tpye
            7'b0010011 : begin
                ALUsrc      = 1'b1;
                MemtoReg    = 3'b001;
                RegWrite    = 1'b1;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b00;
                ALUop       = 2'b10;
                PCsel       = 1'b0;
            end
            
            //Load
            7'b0000011 : begin
                ALUsrc      = 1'b1;
                MemtoReg    = 3'b000;
                RegWrite    = 1'b1;
                MemRead     = 1'b1;
                MemWrite    = 1'b0;
                Branch      = 2'b00;
                ALUop       = 2'b00;
                PCsel       = 1'b0;
            end
            
            //Store
            7'b0100011 : begin
                ALUsrc      = 1'b1;
                MemtoReg    = 3'bxxx;
                RegWrite    = 1'b0;
                MemRead     = 1'b0;
                MemWrite    = 1'b1;
                Branch      = 2'b00;
                ALUop       = 2'b00;
                PCsel       = 1'b0;
            end
            
            //Branch-tpye
            7'b1100011 : begin
                ALUsrc      = 1'b0;
                MemtoReg    = 3'bxxx;
                RegWrite    = 1'b0;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b01;
                ALUop       = 2'b11;
                PCsel       = 1'b0;
            end
            
            //jal
            7'b1101111 : begin
                ALUsrc      = 1'bx;
                MemtoReg    = 3'b010;
                RegWrite    = 1'b1;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b11;
                ALUop       = 2'bxx;
                PCsel       = 1'b0;
            end
            
            //jalr
            7'b1100111 : begin
                ALUsrc      = 1'bx;
                MemtoReg    = 3'b010;
                RegWrite    = 1'b1;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b11;
                ALUop       = 2'b00;
                PCsel       = 1'b1;
            end
            
            //lui
            7'b0110111 : begin
                ALUsrc      = 1'bx;
                MemtoReg    = 3'b011;
                RegWrite    = 1'b1;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b00;
                ALUop       = 2'bxx;
                PCsel       = 1'b0;
            end
            
            //auipc
            7'b0010111 : begin
                ALUsrc      = 1'bx;
                MemtoReg    = 3'b100;
                RegWrite    = 1'b1;
                MemRead     = 1'b0;
                MemWrite    = 1'b0;
                Branch      = 2'b00;
                ALUop       = 2'bxx;
                PCsel       = 1'b0;
            end
            
            default : begin
                ALUsrc      = 1'bx;
                MemtoReg    = 3'bxxx;
                RegWrite    = 1'bx;
                MemRead     = 1'bx;
                MemWrite    = 1'bx;
                Branch      = 1'bx;
                ALUop       = 2'bxx;
                PCsel       = 1'bx;
            end
       endcase   
    end
endmodule
