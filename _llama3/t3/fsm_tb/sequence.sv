class fsm_sequence extends uvm_sequence #(fsm_trans);
    `uvm_object_utils(fsm_sequence)

    rand int unsigned num_transactions;

    constraint num_transactions_constraint {num_transactions inside {[1:10]};}

    function new(string name = "fsm_sequence");
        super.new(name);
    endfunction

    task body();
        fsm_trans trans;
        for (int i = 0; i < num_transactions; i++) begin
            `uvm_do(trans)
        end
    endtask
endclass