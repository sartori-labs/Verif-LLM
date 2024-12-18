// fsm_driver.sv
class fsm_driver extends uvm_driver #(fsm_transaction);
  `uvm_component_utils(fsm_driver)

  virtual fsm_if vif;
  uvm_analysis_port #(fsm_transaction) analysis_port;

  function new(string name = "fsm_driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_error("fsm_driver", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.IN <= req.IN;
      #10;
      analysis_port.write(req);
      seq_item_port.item_done();
    end
  endtask
endclass