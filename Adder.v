module Adder (input[7:0] x,y, output[7:0] z, output carryout);
assign {carryout,z} = x + y;
endmodule //Adder