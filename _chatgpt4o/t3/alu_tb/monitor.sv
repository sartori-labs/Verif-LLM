// alu_monitor.sv - Monitor Class
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
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    alu_transaction tx;
    forever begin
      tx = alu_transaction::type_id::create("tx");
      @(posedge vif.clk);
      // Capture I/O
      tx.a = vif.a;
      tx.b = vif.b;
      tx.aluc = vif.aluc;
      tx.r = vif.r;
      tx.zero = vif.zero;
      tx.carry = vif.carry;
      tx.negative = vif.negative;
      tx.overflow = vif.overflow;
      tx.flag = vif.flag;

      // Send transaction to analysis port
      ap.write(tx);
    end
  endtask
endclass