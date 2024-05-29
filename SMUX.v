`timescale 1ns/1ns

module SMUX (input x, y,input select, output z);

assign z = (~select) ? x : y;

endmodule 