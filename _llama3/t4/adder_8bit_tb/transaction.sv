// Transaction class
class adder_8bit_trans extends uvm_sequence_item;
    rand bit [7:0] a;
    rand bit [7:0] b;
    rand bit cin;
    bit [7:0] sum;
    bit cout;

    `uvm_object_utils_begin(adder_8bit_trans)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(cin, UVM_ALL_ON)
        `uvm_field_int(sum, UVM_ALL_ON)
        `uvm_field_int(cout, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "adder_8bit_trans");
        super.new(name);
    endfunction
endclass
