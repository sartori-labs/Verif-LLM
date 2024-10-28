`ifndef ADDER_8BIT_AGENT_SV
`define ADDER_8BIT_AGENT_SV

class adder_8bit_agent extends uvm_agent;
    adder_8bit_driver driver;
    adder_8bit_monitor monitor;
    adder_8bit_sequencer sequencer;
    virtual adder_8bit_if vif;

    `uvm_component_utils(adder_8bit_agent)

    function new(string name = "adder_8bit_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("AGENT", "Virtual interface not found")
        
        driver = adder_8bit_driver::type_id::create("driver", this);
        monitor = adder_8bit_monitor::type_id::create("monitor", this);
        sequencer = adder_8bit_sequencer::type_id::create("sequencer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        monitor.analysis_port.connect(driver.analysis_port);
    endfunction
endclass

`endif
