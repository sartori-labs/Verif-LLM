// UVM Driver Class
class accu_driver extends uvm_driver #(accu_transaction);
    `uvm_component_utils(accu_driver)

    virtual accu_if vif;
    uvm_analysis_port #(accu_transaction) ap;

    function new(string name = "accu_driver", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif))
            `uvm_fatal("VIF", "Virtual interface not set for accu_driver")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            vif.data_in <= req.data_in;
            vif.valid_in <= req.valid_in;
            @(posedge vif.clk);
            seq_item_port.item_done();
            ap.write(req);
        end
    endtask
endclass