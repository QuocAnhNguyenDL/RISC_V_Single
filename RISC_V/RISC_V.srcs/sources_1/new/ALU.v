`timescale 1ns / 1ps


module ALU(
    input [3:0] ALUcontrol,
    input [31:0] A,B,
    output reg Condition_Branch,
    output reg [31:0] Result
    );
    
    `include "Para.v"
    
    always @(ALUcontrol, A, B)
    begin
        case (ALUcontrol) 
            ADD  : begin 
                Result = A + B; 
                Condition_Branch = 1'b0; 
            end
            SUB  : begin 
                Result = A - B; 
                Condition_Branch = 1'b0; 
            end
            XOR  : begin 
                Result = A ^ B; 
                Condition_Branch = 1'b0; 
            end
            OR   : begin 
                Result = A | B; 
                Condition_Branch = 1'b0; 
            end
            AND  : begin 
                Result = A & B; 
                Condition_Branch = 1'b0; 
            end
            SLL  : begin 
                Result = A << B; 
                Condition_Branch = 1'b0; 
            end
            SRL  : begin 
                Result = A >> B; 
                Condition_Branch = 1'b0; 
            end
            SRA  : begin 
                Result = A >>> B; 
                Condition_Branch = 1'b0;   
            end
            SLT  : begin 
                Result = ($signed(A) < $signed(B)) ? 1'b1 : 1'b0; 
                Condition_Branch = 1'b0; 
            end
            SLTU : begin 
                Result = (A < B) ? 1'b1 : 1'b0; 
                Condition_Branch = 1'b0; 
            end
            EQUAL : begin 
                Result = 0; 
                Condition_Branch = A == B; 
            end
            NEQUAL : begin 
                Result = 0; 
                Condition_Branch = !(A == B); 
            end
            LESS : begin 
                Result = 0; 
                Condition_Branch = $signed(A) < $signed(B); 
            end
            GREATERorEQUAL : begin 
                Result = 0; 
                Condition_Branch = $signed(A) >= $signed(B); 
            end
            LESS_U : begin 
                Result = 0; 
                Condition_Branch = A < B; 
            end
            GREATERorEQUAL_U : begin 
                Result = 0; 
                Condition_Branch = A >= B; 
            end
            default : begin
                Result = 0;
                Condition_Branch = 0;
            end
        endcase
    end
    
    
endmodule
