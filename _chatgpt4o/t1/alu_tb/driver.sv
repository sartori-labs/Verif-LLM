class alu_driver extends uvm_driver #(alu_transaction);
    `uvm_component_utils(alu_driver)

    virtual alu_if vif;
    uvm_analysis_port #(alu_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NO_VIF", "Virtual interface not found")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        alu_transaction tr;
        forever begin
            seq_item_port.get_next_item(tr);
            vif.a <= tr.a;
            vif.b <= tr.b;
            vif.aluc <= tr.aluc;
            #1; // Small delay to simulate timing
            tr.r = vif.r;
            tr.zero = vif.zero;
            tr.carry = vif.carry;
            tr.negative = vif.negative;
            tr.overflow = vif.overflow;
            tr.flag = vif.flag;
            ap.write(tr);
            seq_item_port.item_done();
        end
    endtask
endclass
