// Driver Class
class adder_8bit_driver extends uvm_driver #(adder_8bit_trans);
    `uvm_component_utils(adder_8bit_driver)
    
    virtual adder_8bit_if vif;
    uvm_analysis_port #(adder_8bit_trans) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            adder_8bit_trans trans;
            seq_item_port.get_next_item(trans);
            vif.a = trans.a;
            vif.b = trans.b;
            vif.cin = trans.cin;
            @(posedge vif.clk);
            trans.sum = vif.sum;
            trans.cout = vif.cout;
            ap.write(trans);
            seq_item_port.item_done();
        end
    endtask
endclass