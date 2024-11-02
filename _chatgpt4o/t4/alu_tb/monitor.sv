// Monitor class
class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;
  uvm_analysis_port #(alu_transaction) ap;

  function new(string name = "alu_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MON", "Virtual interface not set for alu_monitor")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_transaction tr;
    forever begin
      tr = alu_transaction::type_id::create("tr", this);
      @(posedge vif.clk);
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