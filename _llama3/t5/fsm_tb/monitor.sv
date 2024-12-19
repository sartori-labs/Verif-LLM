// fsm_monitor.sv
class fsm_monitor extends uvm_monitor;
    `uvm_component_utils(fsm_monitor)

    virtual fsm_if vif;
    uvm_analysis_port#(fsm_trans) item_collected_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name()})
        item_collected_port = new("item_collected_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        fsm_trans trans;

        forever begin
            @(posedge vif.CLK);
            trans = fsm_trans::type_id::create("trans");
            trans.IN = vif.IN;
            trans.MATCH = vif.MATCH;
            item_collected_port.write(trans);
        end
    endtask

endclass