// fsm_monitor.sv
class fsm_monitor extends uvm_monitor;
  `uvm_component_utils(fsm_monitor)

  virtual fsm_if vif;
  fsm_transaction trans;
  uvm_analysis_port #(fsm_transaction) analysis_port;

  function new(string name = "fsm_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_error("MONITOR", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      trans = fsm_transaction::type_id::create("trans");
      #10;
      trans.IN = vif.IN;
      trans.MATCH = vif.MATCH;
      analysis_port.write(trans);
    end
  endtask
endclass