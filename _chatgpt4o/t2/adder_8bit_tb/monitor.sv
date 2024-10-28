`ifndef ADDER_8BIT_MONITOR_SV
`define ADDER_8BIT_MONITOR_SV

class adder_8bit_monitor extends uvm_monitor;
    virtual adder_8bit_if vif;
    uvm_analysis_port #(adder_8bit_trans) analysis_port;
    adder_8bit_trans trans; // Declare transaction object as a class member
    
    `uvm_component_utils(adder_8bit_monitor)

    function new(string name = "adder_8bit_monitor", uvm_component parent = null);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);

        // Initialize the transaction using the standard new() method
        trans = new("trans");
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("MONITOR", "Virtual interface not found");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);

            // Populate the transaction fields using the virtual interface signals
            trans.a = vif.a;
            trans.b = vif.b;
            trans.cin = vif.cin;
            trans.sum = vif.sum;
            trans.cout = vif.cout;

            // Write the transaction to the analysis port
            analysis_port.write(trans);
        end
    endtask
endclass

`endif
