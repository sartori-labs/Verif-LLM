class adder_8bit_sequence extends uvm_sequence#(adder_8bit_trans);

    `uvm_object_utils(adder_8bit_sequence)

    function new(string name = "adder_8bit_sequence");
        super.new(name);
    endfunction

    virtual task pre_body();
        if (starting_phase != null) 
            starting_phase.raise_objection(this);
    endtask

    virtual task body();
        adder_8bit_trans trans;
        for (int i = 0; i < 100; i++) begin
            trans = adder_8bit_trans::type_id::create("trans");
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask

    virtual task post_body();
        if (starting_phase != null) 
            starting_phase.drop_objection(this);
    endtask
endclass
