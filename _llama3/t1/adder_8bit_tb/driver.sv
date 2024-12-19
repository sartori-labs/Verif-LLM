// Driver class
class adder_8bit_driver extends uvm_driver #(adder_8bit_trans);
    `uvm_component_utils(adder_8bit_driver)

    virtual adder_8bit_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    endfunction

    task run_phase(uvm_phase phase);
        adder_8bit_trans req;
        forever begin
            seq_item_port.get_next_item(req);
            drive(req);
            seq_item_port.item_done();
        end
    endtask

    task drive(adder_8bit_trans req);
        vif.a = req.a;
        vif.b = req.b;
        vif.cin = req.cin;
    endtask
endclass