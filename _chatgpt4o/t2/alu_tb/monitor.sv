class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)

    virtual alu_if vif;
    uvm_analysis_port #(alu_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "Virtual interface not set")
    endfunction

    task run_phase(uvm_phase phase);
        alu_transaction trans;
        forever begin
            trans = alu_transaction::type_id::create("trans");
            #1; // Wait for data stability
            trans.a = vif.a;
            trans.b = vif.b;
            trans.aluc = vif.aluc;
            trans.r = vif.r;
            trans.zero = vif.zero;
            trans.carry = vif.carry;
            trans.negative = vif.negative;
            trans.overflow = vif.overflow;
            trans.flag = vif.flag;
            ap.write(trans);
        end
    endtask
endclass
