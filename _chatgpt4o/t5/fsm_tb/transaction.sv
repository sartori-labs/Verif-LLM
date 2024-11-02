`ifndef FSM_TRANSACTION_SV
`define FSM_TRANSACTION_SV

class fsm_transaction extends uvm_sequence_item;
    `uvm_object_utils(fsm_transaction)

    rand bit IN;
    bit MATCH;

    function new(string name = "fsm_transaction");
        super.new(name);
    endfunction

    virtual function void do_copy(uvm_object rhs);
        fsm_transaction rhs_;
        if (!$cast(rhs_, rhs)) begin
            `uvm_fatal("COPY_ERR", "Object casting failed")
        end
        this.IN = rhs_.IN;
        this.MATCH = rhs_.MATCH;
    endfunction
endclass

`endif
