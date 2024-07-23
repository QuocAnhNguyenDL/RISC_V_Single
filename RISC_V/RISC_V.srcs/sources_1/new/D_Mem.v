`timescale 1ns / 1ps

module D_Mem(
    input [9:0] Address,
    input MemWrite, MemRead,
    input [31:0] WriteData,
    input [2:0] Ins14_12,
    input clk, reset,
    output reg [31:0] ReadData
    );
    
    reg [31:0] dmem [0:1023];
    
    wire [31:0] data_reg;
    assign data_reg = dmem[Address];
    
    always @(*)
    begin
        if(MemRead == 1)
            case (Ins14_12)
                3'b000 : ReadData = {{24{data_reg[7]}}, data_reg[7:0]}; //lb
                3'b001 : ReadData = {{16{data_reg[15]}}, data_reg[15:0]}; //lh
                3'b010 : ReadData = {data_reg[31:0]}; //lw
                3'b100 : ReadData = {24'b0, data_reg[7:0]}; //lbu
                3'b101 : ReadData = {16'b0, data_reg[15:0]}; //lhu
                default : ReadData = 32'bx;
            endcase
        else ReadData = 32'bx;
    end
    
    always @(posedge clk)
    begin
        if(MemWrite == 1)
            case (Ins14_12)
                3'b000  : dmem[Address] <= {24'b0, WriteData[7:0]};  //sb
                3'b001  : dmem[Address] <= {16'b0, WriteData[15:0]}; //sh
                3'b010  : dmem[Address] <= WriteData[31:0];          //sw
            endcase  
    end
    
    always @(posedge reset)
    begin
        dmem[15] = -111139;
    end
    
endmodule
