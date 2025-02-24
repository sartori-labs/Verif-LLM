// accu_driver.sv
class accu_driver extends uvm_driver #(accu_transaction);
  `uvm_component_utils(accu_driver)

  virtual accu_if vif;
  uvm_analysis_port #(accu_transaction) analysis_port;

  function new(string name = "accu_driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif)) begin
      `uvm_error("ACC_DRIVER", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.data_in <= req.data_in;
      vif.valid_in <= req.valid_in;
      #10; // Drive the inputs for a certain duration
      analysis_port.write(req);
      seq_item_port.item_done();
    end
  endtask
endclass