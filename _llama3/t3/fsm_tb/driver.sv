class fsm_driver extends uvm_driver #(fsm_trans);
    `uvm_component_utils(fsm_driver)

    virtual fsm_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name()})
        end
    endfunction

    task run_phase(uvm_phase phase);
        fsm_trans trans;
        forever begin
            seq_item_port.get_next_item(trans);
            drive_item(trans);
            seq_item_port.item_done();
        end
    endtask

    task drive_item(fsm_trans trans);
        vif.IN <= trans.IN;
        @(posedge vif.CLK);
    endtask
endclass