class alu_driver extends uvm_driver #(alu_transaction);
    `uvm_component_utils(alu_driver)

    virtual alu_if vif;
    uvm_analysis_port #(alu_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "Virtual interface not set")
    endfunction

    task run_phase(uvm_phase phase);
        alu_transaction trans;
        forever begin
            seq_item_port.get_next_item(trans); // Get transaction from sequencer
            vif.a <= trans.a;
            vif.b <= trans.b;
            vif.aluc <= trans.aluc;
            #1; // Simulate delay for signal assignment
            trans.r = vif.r;
            trans.zero = vif.zero;
            trans.carry = vif.carry;
            trans.negative = vif.negative;
            trans.overflow = vif.overflow;
            trans.flag = vif.flag;
            ap.write(trans);
            seq_item_port.item_done();
        end
    endtask
endclass
