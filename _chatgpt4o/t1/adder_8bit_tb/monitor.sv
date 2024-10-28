class adder_8bit_monitor extends uvm_monitor;

    virtual adder_8bit_if vif;
    uvm_analysis_port#(adder_8bit_trans) ap;

    `uvm_component_utils(adder_8bit_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found");
    endfunction

    virtual task run_phase(uvm_phase phase);
        adder_8bit_trans trans;
        forever begin
            trans = adder_8bit_trans::type_id::create("trans");
            @(posedge vif.clk);
            trans.a = vif.a;
            trans.b = vif.b;
            trans.cin = vif.cin;
            trans.sum = vif.sum;
            trans.cout = vif.cout;
            ap.write(trans);
        end
    endtask
endclass
