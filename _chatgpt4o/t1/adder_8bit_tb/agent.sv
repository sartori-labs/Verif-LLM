class adder_8bit_agent extends uvm_agent;

    virtual adder_8bit_if vif;
    adder_8bit_driver driver;
    adder_8bit_monitor monitor;
    adder_8bit_sequencer sequencer;

    `uvm_component_utils(adder_8bit_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found");
        
        driver = adder_8bit_driver::type_id::create("driver", this);
        monitor = adder_8bit_monitor::type_id::create("monitor", this);
        sequencer = adder_8bit_sequencer::type_id::create("sequencer", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        monitor.ap.connect(driver.ap);
    endfunction

endclass
