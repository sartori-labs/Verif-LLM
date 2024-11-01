// Driver Class
class accu_driver extends uvm_driver #(accu_transaction);
    `uvm_component_utils(accu_driver)

    virtual accu_if vif;  // Virtual interface
    uvm_analysis_port #(accu_transaction) analysis_port;

    // Constructor
    function new(string name = "accu_driver", uvm_component parent = null);
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
        forever begin
            seq_item_port.get_next_item(req);
            vif.valid_in <= req.valid_in;
            vif.data_in <= req.data_in;
            @(posedge vif.clk);
            analysis_port.write(req);
            seq_item_port.item_done();
        end
    endtask
endclass