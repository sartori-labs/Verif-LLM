// Monitor Class
class accu_monitor extends uvm_monitor;
    `uvm_component_utils(accu_monitor)

    virtual accu_if vif;  // Virtual interface
    uvm_analysis_port #(accu_transaction) analysis_port;

    // Constructor
    function new(string name = "accu_monitor", uvm_component parent = null);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")
    endfunction

    // Run phase
    virtual task run_phase(uvm_phase phase);
        accu_transaction trans;
        forever begin
            @(posedge vif.clk);
            trans = accu_transaction::type_id::create("trans");
            trans.data_in = vif.data_in;
            trans.valid_in = vif.valid_in;
            analysis_port.write(trans);
        end
    endtask
endclass