// Transaction Class
class adder_8bit_transaction extends uvm_sequence_item;
    `uvm_object_utils(adder_8bit_transaction)
    
    rand bit [7:0] a;
    rand bit [7:0] b;
    rand bit cin;
    bit [7:0] sum;
    bit cout;

    function new(string name = "adder_8bit_transaction");
        super.new(name);
    endfunction
endclass