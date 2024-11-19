// accu_monitor.sv
class accu_monitor extends uvm_monitor;
  `uvm_component_utils(accu_monitor)

  virtual accu_if vif;
  uvm_analysis_port #(accu_transaction) analysis_port;

  function new(string name = "accu_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif)) begin
      `uvm_error("accu_monitor", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      accu_transaction trans;
      trans = accu_transaction::type_id::create("trans");
      #10; // Sample the outputs after a certain duration
      trans.data_out = vif.data_out;
      trans.valid_out = vif.valid_out;
      analysis_port.write(trans);
    end
  endtask
endclass