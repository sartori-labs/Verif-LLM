// Monitor class
class adder_16bit_monitor extends uvm_monitor;
    `uvm_component_utils(adder_16bit_monitor)

    virtual adder_16bit_if vif;
    uvm_analysis_port #(adder_16bit_transaction) analysis_port;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    // Build phase for setting virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("MON", "Virtual interface not set for the monitor")
        end
    endfunction

    // Main run task
    virtual task run_phase(uvm_phase phase);
        adder_16bit_transaction trans;
        forever begin
            trans = adder_16bit_transaction::type_id::create("trans");
            trans.a = vif.a;
            trans.b = vif.b;
            trans.Cin = vif.Cin;
            #1;  // Sampling point
            trans.y = vif.y;
            trans.Co = vif.Co;
            analysis_port.write(trans);
            `uvm_info("MON", $sformatf("Monitored transaction: a=%0h, b=%0h, Cin=%0b, y=%0h, Co=%0b", trans.a, trans.b, trans.Cin, trans.y, trans.Co), UVM_LOW)
        end
    endtask
endclass
