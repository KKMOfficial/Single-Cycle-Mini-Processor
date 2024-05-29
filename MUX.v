module MUX (input[7:0] x, y,input select, output[7:0] z);
assign z = (select) ? y : x;
endmodule 