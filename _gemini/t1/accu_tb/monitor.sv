// accu_monitor.sv
class accu_monitor extends uvm_monitor;
  `uvm_component_utils(accu_monitor)

  virtual accu_if vif;
  uvm_analysis_port #(accu_transaction) analysis_port;

  function new(string name = "accu_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    
    accu_transaction trans = accu_transaction::type_id::create("trans");

    forever begin
      #10; // Sample the outputs after a certain delay
      trans.valid_out = vif.valid_out;
      `VALID_OUT(trans.valid_out);
      trans.data_out = vif.data_out;
      `DATA_OUT(trans.data_out);
      analysis_port.write(trans);
    end
  endtask
endclass
