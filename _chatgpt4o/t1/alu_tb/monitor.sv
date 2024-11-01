class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)

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
            @(posedge vif.clk); // Wait for a clock cycle
            tr = alu_transaction::type_id::create("tr");
            tr.a = vif.a;
            tr.b = vif.b;
            tr.aluc = vif.aluc;
            tr.r = vif.r;
            tr.zero = vif.zero;
            tr.carry = vif.carry;
            tr.negative = vif.negative;
            tr.overflow = vif.overflow;
            tr.flag = vif.flag;
            ap.write(tr);
        end
    endtask
endclass
