`timescale 1ns / 1ns
module extend3to8 (input [2:0] in, output [7:0] out);

assign out = {5'b00000,in};

endmodule //extend3to8