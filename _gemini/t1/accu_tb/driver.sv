// accu_driver.sv
class accu_driver extends uvm_driver #(accu_transaction);
  `uvm_component_utils(accu_driver)

  virtual accu_if vif;

  function new(string name = "accu_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);  

      vif.data_in <= req.data_in;
      `DATA_IN(req.data_in);
      vif.valid_in <= req.valid_in;
      `VALID_IN(req.valid_in);
      #10; // Drive the inputs for a certain duration
      seq_item_port.item_done();
      analysis_port.write(req);
    end
  endtask
endclass