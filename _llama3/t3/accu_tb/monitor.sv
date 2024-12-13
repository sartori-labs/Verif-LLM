// Monitor class
class accu_monitor extends uvm_monitor;
    virtual accu_if vif;
    uvm_analysis_port#(accu_trans) item_port;

    `uvm_component_utils(accu_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_port = new("item_port", this);
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
            @(posedge vif.clk);
            if (vif.valid_out) begin
                trans = accu_trans::type_id::create("trans");
                trans.data_out = vif.data_out;
                trans.valid_out = vif.valid_out;
                item_port.write(trans);
            end
        end
    endtask
endclass