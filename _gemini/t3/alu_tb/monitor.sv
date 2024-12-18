// alu_monitor.sv
class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;

  // Declare the analysis port
  uvm_analysis_port #(alu_transaction) analysis_port; 

  function new(string name = "alu_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this); // Initialize the port
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_error("ALU_MONITOR", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      alu_transaction trans = alu_transaction::type_id::create("trans");
      #10; // Delay to sample after driver sets values
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
