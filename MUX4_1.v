`timescale 1ns/1ns

module MUX4_1 (input x, y, z, t,input[1:0] select, output q);

assign q = (~select[1]) ? ((~select[0]) ? x : y) : ((~select[0]) ? z : t);

endmodule //MUX4_1