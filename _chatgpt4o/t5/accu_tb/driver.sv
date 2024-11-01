// Driver class
class accu_driver extends uvm_driver #(accu_transaction);
    `uvm_component_utils(accu_driver)

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
        super.run_phase(phase);
        phase.raise_objection(this);
        forever begin
            accu_transaction tr;
            seq_item_port.get_next_item(tr);
            vif.valid_in = tr.valid_in;
            vif.data_in = tr.data_in;
            @(posedge vif.clk);
            seq_item_port.item_done();
            ap.write(tr);
        end
        phase.drop_objection(this);
    endtask
endclass