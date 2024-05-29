`timescale 1ns/1ns

module MUX4 (input[7:0] x, y, z, t,input[1:0] select, output [7:0] q,input clk);

assign q = (~select[1]) ? ((~select[0]) ? x : y) : ((~select[0]) ? z : t);

endmodule //MUX