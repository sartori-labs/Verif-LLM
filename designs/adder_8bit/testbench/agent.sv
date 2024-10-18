class adder_8bit_agent extends uvm_agent;
    
    // Utility Macro
    `uvm_component_utils(adder_8bit_agent)

    // Declare the components and virtual interface
    adder_8bit_driver   driver;
    adder_8bit_monitor  monitor;

    adder_8bit_sequencer sequencer;
    virtual adder_8bit_if vif;
    
    // Constructor
    function new(string name = "adder_8bit_agent", uvm_component parent = null);
        super.new(name, parent);    
    endfunction : new

    // Build Phase - construct the testbench components
    virtual function void build_phase (uvm_phase phase);
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface specified")

        if(get_is_active() == UVM_ACTIVE) begin

            driver = adder_8bit_driver::type_id::create("driver", this);
            sequencer = adder_8bit_sequencer::type_id::create("sequencer", this);
        end

        monitor = adder_8bit_monitor::type_id::create("monitor", this);

    endfunction : build_phase

    // Connect Phase - connect TLM ports of components
    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        if(get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end

    endfunction : connect_phase

endclass