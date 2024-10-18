class adder_8bit_driver extends uvm_driver #(adder_8bit_trans);

    // Utility Macro
    `uvm_component_utils(adder_8bit_driver)

    // Constructor
    function new(string name = "adder_8bit_driver", uvm_component parent = null);
        super.new(name, parent);    
    endfunction  : new

    // Declare virtual interface handle here
    virtual adder_8bit_if vif;

    // Analysis port to broadcast input values to scoreboard
    uvm_analysis_port #(adder_8bit_trans) Drv2Sb_port;

    // Placeholder for the transaction information
    adder_8bit_trans trans;

    // Build Phase - construct the testbench components
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        // Get the virtual interface (if any) here
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", "No virtual interface specified")
        
        Drv2Sb_port = new("Drv2Sb",this);

    endfunction : build_phase

    // Run Phase - main piece of the driver code which decides how it has to translate
    // transaction level objects into pin wiggles at the DUT interface
    virtual task run_phase (uvm_phase phase);
        super.run_phase(phase);

        forever begin
            seq_item_port.get_next_item(trans);

            vif.a <= trans.a;
            vif.b <= trans.b;
            vif.cin <= trans.cin;
            @(posedge vif.clk);

            Drv2Sb_port.write(trans);

            seq_item_port.item_done();
        end
    
    endtask : run_phase

endclass