// Agent class
class adder_16bit_agent extends uvm_agent;
    `uvm_component_utils(adder_16bit_agent)

    adder_16bit_driver driver;
    adder_16bit_sequencer sequencer;
    adder_16bit_monitor monitor;

    virtual adder_16bit_if vif;

    function new(string name = "adder_16bit_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        driver = adder_16bit_driver::type_id::create("driver", this);
        sequencer = adder_16bit_sequencer::type_id::create("sequencer", this);
        monitor = adder_16bit_monitor::type_id::create("monitor", this);
        uvm_config_db#(virtual adder_16bit_if)::set(this, "driver", "vif", vif);
        uvm_config_db#(virtual adder_16bit_if)::set(this, "monitor", "vif", vif);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass
