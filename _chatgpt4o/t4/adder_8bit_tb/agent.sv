// Agent Class
class adder_8bit_agent extends uvm_agent;
    `uvm_component_utils(adder_8bit_agent)

    adder_8bit_sequencer seqr;
    adder_8bit_driver drv;
    adder_8bit_monitor mon;
    virtual adder_8bit_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr = adder_8bit_sequencer::type_id::create("seqr", this);
        drv = adder_8bit_driver::type_id::create("drv", this);
        mon = adder_8bit_monitor::type_id::create("mon", this);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", "Virtual interface not found")
        drv.vif = vif;
        mon.vif = vif;
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
        mon.ap.connect(drv.ap);
    endfunction
endclass