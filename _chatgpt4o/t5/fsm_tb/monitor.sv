`ifndef FSM_MONITOR_SV
`define FSM_MONITOR_SV

class fsm_monitor extends uvm_monitor;
    `uvm_component_utils(fsm_monitor)

    virtual fsm_if vif;
    uvm_analysis_port#(fsm_transaction) ap;

    function new(string name = "fsm_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "Virtual interface not set")
        end
    endfunction

    task run_phase(uvm_phase phase);
        fsm_transaction tr;
        forever begin
            @(posedge vif.CLK);
            tr = fsm_transaction::type_id::create("tr");
            tr.IN = vif.IN;
            tr.MATCH = vif.MATCH;
            ap.write(tr);
        end
    endtask
endclass

`endif
