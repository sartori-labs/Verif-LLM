// interface for adder_8bit
interface adder_8bit_if(input logic clk, input logic rst);
    logic [7:0] a;
    logic [7:0] b;
    logic cin;
    logic [7:0] sum;
    logic cout;
endinterface