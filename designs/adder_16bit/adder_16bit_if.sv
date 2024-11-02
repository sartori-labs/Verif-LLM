interface adder_16bit_if(input logic clk, input logic rst);
    logic [15:0] a;
    logic [15:0] b;
    logic Cin;
    logic [15:0] y;
    logic Co;
endinterface