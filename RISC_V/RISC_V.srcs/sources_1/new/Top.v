`timescale 1ns / 1ps

module Top(
    input clk, reset
    );
    
reg [31:0] PC_in;
wire [31:0] PC_out;
wire [31:0] Ins, DatatoReg, DatafromReg1, DatafromReg2, Imm, SrcforALU1, SrcforALU2, ALUresult, DatafromDmem;
wire [31:0] PC_add_4, Read1_add_Imm, PC_add_Imm, Imm_ShiftLeft12, PC_add_Immshiftleft12;
wire MemRead, MemWrite, ALUsrc, RegWrite, PCsel, Zero;
wire [1:0] ALUop, Branch;
wire [2:0] MemtoReg;
wire [3:0] ALUcontrolsignal;

PC PC_inst(
    .clk(clk),
    .PC_in(PC_in),
    .PC_out(PC_out),
    .reset(reset)
    );
    
I_Mem I_Mem_inst(
    .clk(clk),
    .reset(reset),
    .Address(PC_out),
    .Instruction(Ins)
    );
    
ControlUnit ControlUnit_inst(
    .Opcode(Ins[6:0]),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUsrc(ALUsrc),
    .RegWrite(RegWrite),
    .PCsel(PCsel),
    .ALUop(ALUop),
    .MemtoReg(MemtoReg)
    );
    
Registers Register_inst(
    .clk(clk),
    .reset(reset),
    .ReadAddr1(Ins[19:15]),
    .ReadAddr2(Ins[24:20]),
    .WriteAddr(Ins[11:7]),
    .WriteData(DatatoReg),
    .RegWrite(RegWrite),
    .ReadData1(DatafromReg1),
    .ReadData2(DatafromReg2)
    );
    
Imm_Gen Imm_Gen_inst(
    .Ins(Ins),
    .Imm(Imm)
    );
    
assign SrcforALU1 = DatafromReg1;
assign SrcforALU2 = (ALUsrc == 0) ? DatafromReg2 : Imm;
ALU ALU_inst(
    .ALUcontrol(ALUcontrolsignal),
    .A(SrcforALU1),
    .B(SrcforALU2),
    .Condition_Branch(Zero),
    .Result(ALUresult)
    );
    
ALUcontrol ALUcontrol_inst(
    .ALUop(ALUop),
    .Ins30(Ins[30]),
    .Ins14_12(Ins[14:12]),
    .Control_Signal(ALUcontrolsignal)
    );
    
D_Mem D_Mem_inst(
    .Address(ALUresult),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .WriteData(DatafromReg2),
    .Ins14_12(Ins[14:12]),
    .clk(clk),
    .reset(reset),
    .ReadData(DatafromDmem)
    );
    
Add PCadd4(
    .A(PC_out),
    .B({29'b0,3'b100}),
    .Sum(PC_add_4)
    );
  
Add PCaddimm(
    .A(PC_out),
    .B(Imm),
    .Sum(PC_add_Imm)
    );
 
Add Read1addimm(
    .A(DatafromReg1),
    .B(Imm),
    .Sum(Read1_add_Imm)
    );
    
always @(*)
begin
    if(PCsel == 1) PC_in = Read1_add_Imm;
    else if(Branch[1] == 1) PC_in = PC_add_Imm;
    else if(Branch[0] == 1 & Zero == 1) PC_in = PC_add_Imm;
    else PC_in = PC_add_4;
end
 
assign Imm_ShiftLeft12 = Imm << 12;    
Add PCaddimmshift12(
    .A(Imm_ShiftLeft12),
    .B(PC_out),
    .Sum(PC_add_Immshiftleft12)
    );
    
Mux5to1 RegDataSelect(
    .A(DatafromDmem),
    .B(ALUresult),
    .C(PC_add_4),
    .D(Imm_ShiftLeft12),
    .E(PC_add_Immshiftleft12),
    .M(MemtoReg),
    .Y(DatatoReg)
    );
    

endmodule









