`ifndef FSM_SEQUENCE_SV
`define FSM_SEQUENCE_SV

class fsm_sequence extends uvm_sequence#(fsm_transaction);
    `uvm_object_utils(fsm_sequence)

    function new(string name = "fsm_sequence");
        super.new(name);
    endfunction

    task body();
        fsm_transaction tr;
        for (int i = 0; i < 100; i++) begin
            tr = fsm_transaction::type_id::create("tr");
            assert(tr.randomize());
            start_item(tr);
            finish_item(tr);
        end
    endtask
endclass

`endif
