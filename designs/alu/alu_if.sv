interface alu_if(input logic clk, input logic rst);
    logic [31:0] a;
    logic [31:0] b;
    logic [5:0] aluc;
    logic [31:0] r;
    logic zero;
    logic carry;
    logic negative;
    logic overflow;
    logic flag;
endinterface