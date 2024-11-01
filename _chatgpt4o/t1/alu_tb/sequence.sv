class alu_sequence extends uvm_sequence #(alu_transaction);
    `uvm_object_utils(alu_sequence)

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction

    virtual task body();
        alu_transaction trans;
        for (int i = 0; i < 100; i++) begin
            trans = alu_transaction::type_id::create("trans");
            if (!trans.randomize()) begin
                `uvm_error("alu_sequence", "Failed to randomize transaction")
            end
            start_item(trans);
            finish_item(trans);
        end
    endtask
endclass
