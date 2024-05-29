`timescale 1ns/1ns

module DM(input [7:0] Address,writeData,input clk, readMem, writeMem, output [7:0] readData, output [63:0] DMdata);

reg [7:0] DR [0:7];

integer i = 0;
initial begin
for (i = 0; i<8; i=i+1) begin
    DR[i] = 0;
end
DR[1] = 6;
end

assign DMdata = {DR[0],DR[1],DR[2],DR[3],DR[4],DR[5],DR[6],DR[7]};
assign readData = (readMem == 1) ? DR[Address] : 8'bZ;

always @(posedge clk)begin
    if (writeMem) DR[Address] = writeData;
end

endmodule