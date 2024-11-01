// Sequence Class
class adder_8bit_seq extends uvm_sequence #(adder_8bit_trans);
    `uvm_object_utils(adder_8bit_seq)
    
    function new(string name = "adder_8bit_seq");
        super.new(name);
    endfunction

    virtual task body();
        adder_8bit_trans trans;
        for (int i = 0; i < 100; i++) begin
            trans = adder_8bit_trans::type_id::create("trans");
            start_item(trans);
            if (!trans.randomize()) begin
                `uvm_warning("RANDOMIZATION_FAILED", "Randomization of transaction failed")
            end
            finish_item(trans);
        end
    endtask
endclass