`timescale 1ns/1ns
`include "DM.v"
`include "IM.v"
`include "RegBank.v"
`include "controller.v"
`include "MUX.v"
`include "SMUX.v"
`include "Adder.v"
`include "register.v"
`include "register4.v"
`include "instructionDecoder.v"
`include "ALU.v"
`include "MUX4.v"
`include "MUX4_1.v"
`include "extend3to8.v"

module mini_processor (output jump,ReadDMem,WriteDMem,regWrite,carryOut,input clk,output[15:0] instructionMemoryOutput, output[7:0] mainAluResult,Reg1MemData,Reg2MemData,writeDataFeedBack,ssOutput,dataMemoryOutput,immidiate,output [63:0]dataLookUp,DMdata,output[3:0] flagReg,output correction);

wire dummy,aluSecOperand;
wire [7:0]  pcOutput,pcInput,pcAdderOutput,
            regImmidiateMUXOutput;
            // dataMemoryOutput;
// wire [15:0] instructionMemoryOutput;
wire [2:0] Reg1ReadAddress,Reg2ReadAddress;
// wire [7:0] immidiate;
wire [1:0] feedBackMUX;
wire [3:0] ALUOperation;
wire [19:0]outputBus;
wire ZeroFlagIN,
     CarryFlagIN,
     OverflowFlagIN,
     SignFlagIN,
     ZeroFlagOUT,
     SignFlagOUT,
     CarryFlagOUT,
     OverflowFlagOUT,
     AluZero;
wire updateOFF,
     updateZF,
     updateCF,
     updateSF;
wire [1:0] OFFCtrl,ZFCtrl,CFCtrl,SFCtrl;


assign flagReg = {ZeroFlagOUT,SignFlagOUT,CarryFlagOUT,OverflowFlagOUT};

register pcReg(pcOutput, pcInput, clk);
Adder pcAdder(pcOutput, 8'b00000001, pcAdderOutput, dummy);
MUX jumpMUX(pcAdderOutput,immidiate,jump,pcInput);

MUX sevenSegmentData(8'b00000000, Reg1MemData, ssCtrl, ssOutput);

register4 flagRegister({ZeroFlagOUT,SignFlagOUT,CarryFlagOUT,OverflowFlagOUT},{ZeroFlagIN,SignFlagIN,CarryFlagIN,OverflowFlagIN},clk);

assign updateOFF = (~correction&carryOut&((Reg1MemData[7]&Reg2MemData[7]&~mainAluResult[7])|(~Reg1MemData[7]&~Reg2MemData[7]&mainAluResult[7])))|(correction&(Reg1MemData[7]^mainAluResult[7]));
assign updateZF  = AluZero;
assign updateCF  = carryOut;
assign updateSF  = mainAluResult[7];

MUX4_1 OFFlag(1'b0,1'b1,updateOFF,OverflowFlagOUT,OFFCtrl,OverflowFlagIN);
MUX4_1 ZFlag(1'b0,1'b1,updateZF,ZeroFlagOUT,ZFCtrl,ZeroFlagIN);
MUX4_1 CFlag(1'b0,1'b1,updateCF,CarryFlagOUT,CFCtrl,CarryFlagIN);
MUX4_1 SFlag(1'b0,1'b1,updateSF,SignFlagOUT,SFCtrl,SignFlagIN);


IM instructionMemory(pcOutput,clk,instructionMemoryOutput);
instructionDecoder insDecoder(Reg1ReadAddress,Reg2ReadAddress,immidiate,instructionMemoryOutput,clk);
RegBank registerFile(Reg1MemData,Reg2MemData,Reg1ReadAddress,Reg2ReadAddress,Reg1ReadAddress,writeDataFeedBack,regWrite,clk,dataLookUp);

MUX regImmidiate(Reg2MemData,immidiate,aluSecOperand,regImmidiateMUXOutput);
ALU alUnit(Reg1MemData,regImmidiateMUXOutput,ALUOperation,mainAluResult,AluZero,carryOut);

DM dataMemoryUnit(immidiate,mainAluResult,clk,ReadDMem,WriteDMem,dataMemoryOutput,DMdata);
MUX4 dataMemoryMUX(mainAluResult,dataMemoryOutput,immidiate,8'b00000000,feedBackMUX,writeDataFeedBack,clk);

controller controlUnit(ssCtrl,clk,instructionMemoryOutput[15:6],ZeroFlagOUT,SignFlagOUT,CarryFlagOUT,OverflowFlagOUT,jump,ReadDMem,WriteDMem,feedBackMUX,regWrite,ALUOperation,aluSecOperand,outputBus,OFFCtrl,ZFCtrl,CFCtrl,SFCtrl,correction);


endmodule 
