`include "RegBank.v"
`timescale  1ns/1ns

module tb_RegBank();

initial begin
    $dumpfile("RegBank.vcd");
    $dumpvars(1, tb_RegBank);
end

reg clk = 0;

reg [2:0]
       readRegister1 ,
       readRegister2 ,
       writeRegister ;

reg [7:0]
       writeData;

wire [7:0] 
        readData1 ,
        readData2 ;

RegBank testUnit(readData1, readData2, readRegister1, readRegister2, writeRegister, writeData,clk);

always #10 clk = ~clk;

initial begin
    
readRegister1 = 3;
readRegister2 = 4;
writeRegister = 1;
writeData = 66;
#20;
readRegister1 = 1;
readRegister2 = 4;
writeRegister = 4;
writeData = 2;
#20;
readRegister1 = 1;
readRegister2 = 4;
writeRegister = 5;
writeData = 33;
#20;
$stop;
end


endmodule