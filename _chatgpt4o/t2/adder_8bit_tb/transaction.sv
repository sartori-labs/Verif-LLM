// Transaction Class
class adder_8bit_trans extends uvm_sequence_item;
    rand bit [7:0] a;
    rand bit [7:0] b;
    rand bit cin;
    bit [7:0] sum;
    bit cout;

    `uvm_object_utils(adder_8bit_trans)

    function new(string name = "adder_8bit_trans");
        super.new(name);
    endfunction

    function void display();
        $display("Transaction: a=%0d, b=%0d, cin=%0d, sum=%0d, cout=%0d", a, b, cin, sum, cout);
    endfunction
endclass