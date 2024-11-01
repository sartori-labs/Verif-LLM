// UVM Transaction Class
class accu_transaction extends uvm_sequence_item;
    `uvm_object_utils(accu_transaction)

    rand bit [7:0] data_in;
    bit valid_in;
    bit [9:0] data_out; // output from DUT, not randomized
    bit valid_out;

    function new(string name = "accu_transaction");
        super.new(name);
    endfunction
endclass