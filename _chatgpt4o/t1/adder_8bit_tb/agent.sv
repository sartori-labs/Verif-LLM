// Agent Class
class adder_8bit_agent extends uvm_agent;
    `uvm_component_utils(adder_8bit_agent)

    adder_8bit_sequencer sequencer;
    adder_8bit_driver driver;
    adder_8bit_monitor monitor;
    virtual adder_8bit_if vif;

    function new(string name = "adder_8bit_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")

        sequencer = adder_8bit_sequencer::type_id::create("sequencer", this);
        driver = adder_8bit_driver::type_id::create("driver", this);
        monitor = adder_8bit_monitor::type_id::create("monitor", this);

        driver.vif = vif;
        monitor.vif = vif;
    endfunction

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass