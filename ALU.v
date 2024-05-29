`timescale 1ns / 1ns

module ALU (input[7:0] x,y,input [3:0]operation, output reg[7:0]z,output reg zero,carryout);

initial carryout = 0;
reg [7:0]dummy;

always @(x,y) begin
    zero = x == y;
    carryout = 0;
    
    case(operation)
        0: {carryout,z} = x + y;
        1: z = x & y;
        2: {carryout,z} = x - y;
        3: z = x | y;
        4: z = x ^ y;
        5: z = y;
        6: z = ~x;
        7: z = x >>> y;
        8: z = x >> y;
        9: z = x <<< y;
        10: z = x << y;
        11: {z,dummy} = {x,x} << y;//rotation left === shift left double_bus :D
        12: {z,dummy} = {x,x} >> y;//
        13: z = x+1;
        14: z = x-1;
        
    endcase
end
endmodule //ALU