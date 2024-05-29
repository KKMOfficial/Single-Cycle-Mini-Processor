`timescale 1ns/1ns

module register (output reg [7:0]parallelOutput, input [7:0]parallelInput, input clk);

initial begin
parallelOutput = 0;
end


always @(posedge clk)
begin
parallelOutput =  parallelInput;
end

endmodule //register