// UVM Monitor Class
class accu_monitor extends uvm_monitor;
    `uvm_component_utils(accu_monitor)

    virtual accu_if vif;
    uvm_analysis_port #(accu_transaction) ap;

    function new(string name = "accu_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif))
            `uvm_fatal("VIF", "Virtual interface not set for accu_monitor")
    endfunction

    task run_phase(uvm_phase phase);
        accu_transaction trans;
        forever begin
            @(posedge vif.clk);
            trans = accu_transaction::type_id::create("trans");
            trans.data_in = vif.data_in;
            trans.valid_in = vif.valid_in;
            trans.valid_out = vif.valid_out;
            trans.data_out = vif.data_out;
            ap.write(trans);
        end
    endtask
endclass