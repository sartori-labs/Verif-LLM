// adder_16bit_monitor.sv
`ifndef ADDER_16BIT_MONITOR_SV
`define ADDER_16BIT_MONITOR_SV

class adder_16bit_monitor extends uvm_monitor;
    `uvm_component_utils(adder_16bit_monitor)

    virtual adder_16bit_if vif;
    uvm_analysis_port #(adder_16bit_transaction) ap;

    function new(string name = "adder_16bit_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            adder_16bit_transaction trans = adder_16bit_transaction::type_id::create("trans");
            #1; // Wait for simulation tick

            // Sampling signals
            trans.a = vif.a;
            trans.b = vif.b;
            trans.Cin = vif.Cin;
            trans.y = vif.y;
            trans.Co = vif.Co;

            ap.write(trans);
        end
    endtask
endclass

`endif // ADDER_16BIT_MONITOR_SV
