class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)

    alu_sequencer seqr;
    alu_driver drv;
    alu_monitor mon;
    virtual alu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr = alu_sequencer::type_id::create("seqr", this);
        drv = alu_driver::type_id::create("drv", this);
        mon = alu_monitor::type_id::create("mon", this);

        if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
            `uvm_fatal("AGT", "Virtual interface not set")

        drv.vif = vif;
        mon.vif = vif;
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect sequencer and driver
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass
