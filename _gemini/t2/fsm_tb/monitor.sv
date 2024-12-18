// monitor.sv
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  virtual fsm_if vif;
  uvm_analysis_port #(transaction) analysis_port;

  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_error("MONITOR", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      transaction trans;
      trans = transaction::type_id::create("trans");
      #10; // Wait for some time
      trans.IN = vif.IN;
      trans.MATCH = vif.MATCH;
      analysis_port.write(trans);
    end
  endtask
endclass