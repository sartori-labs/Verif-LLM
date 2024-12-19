// alu_sequence.sv
class alu_sequence extends uvm_sequence#(alu_trans);
    `uvm_object_utils(alu_sequence)

    rand int num_transactions;

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction

    task body();
        alu_trans trans;
        for (int i = 0; i < num_transactions; i++) begin
            trans = alu_trans::type_id::create("trans");
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask
endclass