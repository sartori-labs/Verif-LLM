// Monitor class
class accu_monitor extends uvm_monitor;
    `uvm_component_utils(accu_monitor)

    virtual accu_if vif;
    uvm_analysis_port #(accu_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        accu_transaction tr;
        forever begin
            @(posedge vif.clk);
            tr = accu_transaction::type_id::create("tr");
            tr.valid_in = vif.valid_in;
            tr.data_in = vif.data_in;
            tr.valid_out = vif.valid_out;
            tr.data_out = vif.data_out;
            ap.write(tr);
        end
    endtask
endclass