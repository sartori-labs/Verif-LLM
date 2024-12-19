// monitor.sv
class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;
  uvm_analysis_port #(alu_trans) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_port = new("analysis_port", this);
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    alu_trans trans;
    forever begin
      @(posedge vif.clk);
      trans = alu_trans::type_id::create("trans");
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