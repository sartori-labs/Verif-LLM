// adder_16bit_transaction.sv
`ifndef ADDER_16BIT_TRANSACTION_SV
`define ADDER_16BIT_TRANSACTION_SV

class adder_16bit_transaction extends uvm_sequence_item;
    `uvm_object_utils(adder_16bit_transaction)

    rand bit [15:0] a;
    rand bit [15:0] b;
    rand bit        Cin;
    bit [15:0]      y;
    bit             Co;

    function new(string name = "adder_16bit_transaction");
        super.new(name);
    endfunction
endclass

`endif // ADDER_16BIT_TRANSACTION_SV
