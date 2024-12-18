// alu_monitor.sv
class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;
  uvm_analysis_port #(alu_transaction) analysis_port;

  function new(string name = "alu_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_error("ALU_MONITOR", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      alu_transaction trans;
      trans = alu_transaction::type_id::create("trans");
      #10; // Wait for some time after the driver sets the inputs
      trans.a = vif.a;
      trans.b = vif.b;
      trans.aluc = vif.aluc;
      trans.r = vif.r;
      trans.zero = vif.zero;
      trans.carry = vif.carry;
      trans.negative = vif.negative;
      trans.overflow = vif.overflow;
      trans.flag = vif.flag;
      analysis_port.write(trans);
    end
  endtask
endclass