`include "mini_processor.v"
`timescale  1ns/1ns

module tb_mini_processor();

initial begin
    $dumpfile("mini_processor.vcd");
    $dumpvars(1, tb_mini_processor);
end

reg clk;
wire[7:0]immidiate,Reg1MemData,Reg2MemData,writeDataFeedBack,ssOutput,mainAluResult,dataMemoryOutput;
wire[3:0]flagReg;
wire[15:0] instructionMemoryOutput;
wire [63:0]dataLookUp,DMdata;
wire correction,jump,ReadDMem,WriteDMem,regWrite,carryOut;


initial clk = 0;

always #10 clk = ~clk;

mini_processor mp(jump,ReadDMem,WriteDMem,regWrite,carryOut,clk,instructionMemoryOutput,mainAluResult,Reg1MemData,Reg2MemData,writeDataFeedBack,ssOutput,dataMemoryOutput,immidiate,dataLookUp,DMdata,flagReg,correction);

initial begin
#20;
#20;
#20;
#20;
#20;
#20;
#20;
#20;
#20;
#20;
#20;
$stop;
end

endmodule