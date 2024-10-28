`ifndef ADDER_8BIT_SEQUENCE_SV
`define ADDER_8BIT_SEQUENCE_SV

class adder_8bit_sequence extends uvm_sequence #(adder_8bit_trans);

    `uvm_object_utils(adder_8bit_sequence)

    function new(string name = "adder_8bit_sequence");
        super.new(name);
    endfunction

    task pre_body();
        if (starting_phase != null)
            starting_phase.raise_objection(this);
    endtask

    task body();
        adder_8bit_trans trans;
        repeat(100) begin
            trans = adder_8bit_trans::type_id::create("trans");
            assert(this.randomize());
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask

    task post_body();
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass

`endif
