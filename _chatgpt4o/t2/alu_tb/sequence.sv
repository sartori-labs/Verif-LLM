class alu_sequence extends uvm_sequence #(alu_transaction);
    `uvm_object_utils(alu_sequence)

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction

    task body();
        alu_transaction trans;
        repeat(100) begin // Generate multiple transactions for high coverage
            trans = alu_transaction::type_id::create("trans");
            if (!trans.randomize()) begin
                `uvm_error("SEQUENCE", "Randomization failed")
            end
            start_item(trans);
            finish_item(trans);
        end
    endtask
endclass
