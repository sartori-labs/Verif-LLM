// Driver class
class accu_driver extends uvm_driver#(accu_trans);
    virtual accu_if vif;

    `uvm_component_utils(accu_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual accu_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
    endfunction

    task run_phase(uvm_phase phase);
        accu_trans trans;
        forever begin
            seq_item_port.get_next_item(trans);
            drive_item(trans);
            seq_item_port.item_done();
        end
    endtask

    task drive_item(accu_trans trans);
        @(posedge vif.clk);
        vif.data_in <= trans.data_in;
        vif.valid_in <= trans.valid_in;
    endtask
endclass