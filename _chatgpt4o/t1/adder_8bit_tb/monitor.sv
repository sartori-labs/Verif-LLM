// Monitor Class
class adder_8bit_monitor extends uvm_monitor;
    `uvm_component_utils(adder_8bit_monitor)

    virtual adder_8bit_if vif;
    uvm_analysis_port #(adder_8bit_transaction) ap;

    function new(string name = "adder_8bit_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            adder_8bit_transaction trans = adder_8bit_transaction::type_id::create("trans");
            @(posedge vif.cin); // Wait for a change in cin
            trans.a = vif.a;
            trans.b = vif.b;
            trans.cin = vif.cin;
            trans.sum = vif.sum;
            trans.cout = vif.cout;
            ap.write(trans);
        end
    endtask
endclass