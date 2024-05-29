`timescale  1ns/1ns

module RegBank (readData1, readData2, readRegister1, readRegister2, writeRegister, writeData,regWrite, clk, dataLookUp);

reg [7:0] R [0:7];

input clk,regWrite;

input [2:0]
       readRegister1 ,
       readRegister2 ,
       writeRegister ;

input [7:0]
       writeData;

output [7:0] 
        readData1 ,
        readData2 ;

output [63:0] dataLookUp;


integer i;
initial begin
for (i = 0; i<8; i=i+1) begin
    R[i] = 0;    
end
end


assign readData1 = R[readRegister1];
assign readData2 = R[readRegister2];
assign dataLookUp = {R[0],R[1],R[2],R[3],R[4],R[5],R[6],R[7]};


always @(posedge clk) begin
    if(regWrite) R[writeRegister] = writeData;
end



endmodule //RegBank