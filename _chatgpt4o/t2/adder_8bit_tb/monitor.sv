// Monitor Class
class adder_8bit_monitor extends uvm_monitor;
    `uvm_component_utils(adder_8bit_monitor)

    virtual adder_8bit_if vif;
    uvm_analysis_port #(adder_8bit_trans) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
        end
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            adder_8bit_trans trans = adder_8bit_trans::type_id::create("trans");
            @(posedge vif.sum);
            trans.a = vif.a;
            trans.b = vif.b;
            trans.cin = vif.cin;
            trans.sum = vif.sum;
            trans.cout = vif.cout;
            ap.write(trans);
        end
    endtask
endclass