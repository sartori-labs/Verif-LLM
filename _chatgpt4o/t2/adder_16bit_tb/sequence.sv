// adder_16bit_sequence.sv
`ifndef ADDER_16BIT_SEQUENCE_SV
`define ADDER_16BIT_SEQUENCE_SV

class adder_16bit_sequence extends uvm_sequence #(adder_16bit_transaction);
    `uvm_object_utils(adder_16bit_sequence)

    function new(string name = "adder_16bit_sequence");
        super.new(name);
    endfunction

    virtual task body();
        adder_16bit_transaction trans;
        repeat (100) begin
            trans = adder_16bit_transaction::type_id::create("trans");
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask
endclass

`endif // ADDER_16BIT_SEQUENCE_SV
