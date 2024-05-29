`timescale 1ns/1ns

module register4 (output reg [3:0]parallelOutput, input [3:0]parallelInput, input clk);

initial
begin
parallelOutput = 0;
end


always @(posedge clk)
begin
parallelOutput = parallelInput;
end

endmodule //register