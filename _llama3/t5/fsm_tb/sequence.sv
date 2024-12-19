// fsm_sequence.sv
class fsm_sequence extends uvm_sequence#(fsm_trans);
    `uvm_object_utils(fsm_sequence)

    rand int num_transactions;

    constraint num_transactions_constraint {num_transactions inside {[1:10]};}

    function new(string name = "fsm_sequence");
        super.new(name);
    endfunction

    task body();
        fsm_trans trans;

        repeat(num_transactions) begin
            trans = fsm_trans::type_id::create("trans");
            start_item(trans);
            finish_item(trans);
        end
    endtask

endclass