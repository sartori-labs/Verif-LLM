// driver.sv
class driver extends uvm_driver #(transaction);
  `uvm_component_utils(driver)

  virtual fsm_if vif;
  uvm_analysis_port #(transaction) analysis_port;

  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_error("DRIVER", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.IN <= req.IN;
      #10; // Wait for some time
      analysis_port.write(req);
      seq_item_port.item_done();
    end
  endtask
endclass