`ifndef ADDER_8BIT_TRANS_SV
`define ADDER_8BIT_TRANS_SV

class adder_8bit_trans extends uvm_sequence_item;
    rand bit [7:0] a;      // 8-bit input 'a'
    rand bit [7:0] b;      // 8-bit input 'b'
    rand bit cin;          // 1-bit input 'cin'
    bit [7:0] sum;         // 8-bit output 'sum'
    bit cout;              // 1-bit output 'cout'

    // Utility macros for the class
    `uvm_object_utils_begin(adder_8bit_trans)
        // Use UVM_ALL_ON for all I/O fields (inputs and outputs)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(cin, UVM_ALL_ON)
        `uvm_field_int(sum, UVM_ALL_ON)
        `uvm_field_int(cout, UVM_ALL_ON)
    `uvm_object_utils_end

    // Constructor
    function new(string name = "adder_8bit_trans");
        super.new(name);
    endfunction
endclass

`endif
