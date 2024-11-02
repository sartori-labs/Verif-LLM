`ifndef FSM_AGENT_SV
`define FSM_AGENT_SV

class fsm_agent extends uvm_agent;
    `uvm_component_utils(fsm_agent)

    fsm_sequencer seqr;
    fsm_driver drv;
    fsm_monitor mon;
    virtual fsm_if vif;

    function new(string name = "fsm_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr = fsm_sequencer::type_id::create("seqr", this);
        drv = fsm_driver::type_id::create("drv", this);
        mon = fsm_monitor::type_id::create("mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
        mon.ap.connect(drv.ap);
    endfunction
endclass

`endif
