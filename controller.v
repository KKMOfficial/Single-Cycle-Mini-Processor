module controller (
    output reg ssCtrl,
    input clk,
    input [9:0]opcode,
    input ZeroFlag,
          SignFlag,
          CarryFlag,
          OverflowFlag, 
    output reg jump,
           ReadDMem,
           WriteDMem,
    output reg [1:0]feedBackMUX,
    output reg regWrite,
    output reg [3:0] ALUOperation,
    output reg aluSecOperand,
    output reg [19:0] outputBus,
    output reg [1:0] OFFCtrl,ZFCtrl,CFCtrl,SFCtrl,
    output reg correction
    
);

// ZeroFlag     : indicate zero value of one register and more...
// SignFlag     : MSB of one operation
// CarryFlag    : carry out of the alu
// OverflowFlag : compare sign of result and operands
initial begin
correction = 0;
end
// reg[11:0] outputBus;

initial begin
{jump,ReadDMem,WriteDMem,feedBackMUX,regWrite,aluSecOperand,ALUOperation,OFFCtrl,ZFCtrl,CFCtrl,SFCtrl} = 19'b0000000000000000000;
end

always @(opcode) begin

    ssCtrl = 0;
    correction = 0;

    //feedback mainAluResult,dataMemoryOutput,immidiate,8'b00000000
    //alusecondoperand reg2Data,immidiate
    //force 0, force 1, update, keep
    if(opcode[9]==0)
    begin   
        case (opcode[8:0])
        9'b000000000: outputBus = 19'b0_0_0_00_0_0_0000_11_11_11_11;
        9'b000000001: outputBus = 19'b0_0_0_00_1_0_0000_10_10_10_10;
        9'b000000010: outputBus = 19'b0_0_0_00_1_0_0001_00_10_00_10;
        9'b000000011: outputBus = 19'b0_0_0_00_1_0_0010_10_10_10_10;
        9'b000000100: outputBus = 19'b0_0_0_00_1_0_0011_00_10_00_10;
        9'b000000101: outputBus = 19'b0_0_0_00_1_0_0100_00_10_00_10;
        9'b000000110: outputBus = 19'b0_0_0_00_1_0_0101_11_11_11_11;
        9'b000001000: outputBus = 19'b0_0_0_00_1_0_0110_11_11_11_11;

        9'b000001001: begin outputBus = 19'b0_0_0_00_1_1_0111_10_10_10_10; correction = 1; end
        9'b000001010: begin outputBus = 19'b0_0_0_00_1_1_1000_10_10_10_10; correction = 1; end
        9'b000001011: begin outputBus = 19'b0_0_0_00_1_1_1001_10_10_10_10; correction = 1; end
        9'b000001100: begin outputBus = 19'b0_0_0_00_1_1_1010_10_10_10_10; correction = 1; end
        9'b000001101: begin outputBus = 19'b0_0_0_00_1_1_1011_10_10_10_10; correction = 1; end
        9'b000001110: begin outputBus = 19'b0_0_0_00_1_1_1100_10_10_10_10; correction = 1; end

        9'b000001111: outputBus = 19'b0_0_0_00_1_0_1110_10_10_10_10;
        9'b000010000: outputBus = 19'b0_0_0_00_1_0_1111_10_10_10_10;
        9'b000010100: outputBus = 19'b0_0_0_00_0_1_0010_10_10_10_10;
        9'b000010011: begin outputBus = 19'b0_0_0_00_0_0_0000_11_11_11_11; ssCtrl = 1; end
        endcase
    end
    else if(opcode[9]==1) 
    begin
        case (opcode[8:5])
        //complete right hand
        // {jump,ReadDMem,WriteDMem,feedBackMUX,regWrite,aluSecOperand,ALUOperation,FlagChangeCtrl}
        //feedback mainAluResult,dataMemoryOutput,immidiate,8'b00000000
        //alusecondoperand reg2Data,immidiate
        4'b0000: if(ZeroFlag) outputBus = 19'b1001101000011111111; else outputBus = 19'b0000000000011111111;
        4'b0001: if(CarryFlag) outputBus = 19'b1001101000011111111; else outputBus = 19'b0000000000011111111;
        4'b0010: if(ZeroFlag&CarryFlag) outputBus = 19'b1001101000011111111; else outputBus = 19'b0000000000011111111;
        4'b0011: if(ZeroFlag!=OverflowFlag)outputBus = 19'b1001101000011111111; else outputBus = 19'b0000000000011111111;
        4'b0100: if((!ZeroFlag)&(SignFlag==OverflowFlag)) outputBus = 19'b1001101000011111111; else outputBus = 19'b0000000000011111111;
        4'b0101: outputBus = 19'b1001101000011111111;
        4'b0110: outputBus = 19'b0001010000011111111;
        4'b0111: outputBus = 19'b0100111010111111111;
            
        endcase
    end

    {jump,ReadDMem,WriteDMem,feedBackMUX,regWrite,aluSecOperand,ALUOperation,OFFCtrl,ZFCtrl,CFCtrl,SFCtrl} = outputBus;


end

endmodule //controller