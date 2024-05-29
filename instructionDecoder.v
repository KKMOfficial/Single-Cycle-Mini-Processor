`timescale 1ns / 1ns
module instructionDecoder (output reg[2:0] reg1,reg2, output reg[7:0]immidiate,input[15:0]instruction,input clk);

always @(instruction)
begin

if(instruction[15] == 0)
begin
reg1 = instruction[5:3];
reg2 = instruction[2:0];
immidiate = {5'b00000,reg2};
end
else if(instruction[15] == 1)
begin
reg1 = instruction[10:8];
reg2 = 3'bZ;
immidiate = instruction[7:0];
end

end

endmodule //instructionDecoder