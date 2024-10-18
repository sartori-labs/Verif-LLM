class adder_8bit_monitor extends uvm_monitor;

    // Utility Macro
    `uvm_component_utils(adder_8bit_monitor)

    // Declare virtual interface handle here
    virtual adder_8bit_if vif;

    // Analysis port to broadcast results to scoreboard
    uvm_analysis_port #(adder_8bit_trans) Mon2Sb_port;

    // Placeholder for the transaction information
    adder_8bit_trans trans_record;

    // Constructor
    function new(string name = "adder_8bit_monitor", uvm_component parent = null);
        super.new(name, parent);

        trans_record = new("trans_record");

        Mon2Sb_port = new("Mon2Sb", this);    
    endfunction : new

    // Build Phase - construct the testbench components
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        // Get the virtual interface (if any) here
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface specified")
        
    endfunction : build_phase

    // Run Phase - main piece of the monitor code which 
    // decides how it captures transaction level objects
    virtual task run_phase (uvm_phase phase);
        
        forever begin
            @(posedge vif.clk);
            // trans = adder_8bit_transaction::type_id::create("tr");
            trans_record.a <= vif.a;
            trans_record.b <= vif.b;
            trans_record.cin <= vif.cin;
            trans_record.sum <= vif.sum;
            trans_record.cout <= vif.cout;
            Mon2Sb_port.write(trans_record);
        end
        
    endtask : run_phase

endclass