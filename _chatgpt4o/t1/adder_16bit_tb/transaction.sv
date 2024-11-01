// Transaction class representing input/output of the DUT
class adder_16bit_transaction extends uvm_sequence_item;
    `uvm_object_utils(adder_16bit_transaction)

    rand bit [15:0] a;
    rand bit [15:0] b;
    rand bit Cin;
    bit [15:0] y;
    bit Co;

    // Constructor
    function new(string name = "adder_16bit_transaction");
        super.new(name);
    endfunction

    // Constraints can be added here if needed
endclass
