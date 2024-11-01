// Sequence Class
class accu_sequence extends uvm_sequence #(accu_transaction);
    `uvm_object_utils(accu_sequence)

    // Constructor
    function new(string name = "accu_sequence");
        super.new(name);
    endfunction

    // Body task
    virtual task body();
        accu_transaction trans;
        for (int i = 0; i < 16; i++) begin  // Fixed iteration for multiple transactions
            trans = accu_transaction::type_id::create("trans");
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask
endclass