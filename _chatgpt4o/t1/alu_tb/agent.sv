class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)

    alu_sequencer sequencer;
    alu_driver driver;
    alu_monitor monitor;
    virtual alu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequencer = alu_sequencer::type_id::create("sequencer", this);
        driver = alu_driver::type_id::create("driver", this);
        monitor = alu_monitor::type_id::create("monitor", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif);
        driver.vif = vif;
        monitor.vif = vif;
    endfunction
endclass
