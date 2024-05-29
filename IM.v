`timescale 1ns/1ns

module IM(input [7:0] readAddress, input clk,output reg[15:0] instruction);

reg [15:0] IR [255:0];

integer i = 0;
initial begin
for (i = 0; i<256; i=i+1) begin
    IR[i] = 0;    
end
end

initial begin
//testing instructions
IR[0]=16'b1011000110000000;     // reg1 <- 128
IR[1]=16'b0000000110011001;     // reg3 <- reg1
IR[2]=16'b0000001101001001;     // reg1 <- Rotate_Left(reg1, 1) :result must be 1
IR[3]=16'b0000010000001001;     // reg1 <- reg1 - 1
IR[4]=16'b0000001111001001;     // reg1 <- reg1 + 1





end

always @(readAddress) instruction = IR[readAddress];

endmodule