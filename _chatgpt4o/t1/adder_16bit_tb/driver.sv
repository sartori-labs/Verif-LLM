// Driver class
class adder_16bit_driver extends uvm_driver #(adder_16bit_transaction);
    `uvm_component_utils(adder_16bit_driver)

    virtual adder_16bit_if vif;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase for setting virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("DRV", "Virtual interface not set for the driver")
        end
    endfunction

    // Main run task
    virtual task run_phase(uvm_phase phase);
        adder_16bit_transaction trans;
        forever begin
            seq_item_port.get_next_item(trans);
            vif.a = trans.a;
            vif.b = trans.b;
            vif.Cin = trans.Cin;
            #1;  // Wait for outputs to settle
            trans.y = vif.y;
            trans.Co = vif.Co;
            seq_item_port.item_done();
            `uvm_info("DRV", $sformatf("Driving transaction: a=%0h, b=%0h, Cin=%0b", trans.a, trans.b, trans.Cin), UVM_LOW)
        end
    endtask
endclass
