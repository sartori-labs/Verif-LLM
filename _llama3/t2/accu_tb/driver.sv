// accu_driver.sv
`ifndef ACCU_DRIVER_SV
`define ACCU_DRIVER_SV

class accu_driver extends uvm_driver#(accu_trans);
  `uvm_component_utils(accu_driver)

  virtual accu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual accu_if)::get(this, "", "accu_if", vif)) begin
      `uvm_fatal("ACCUDRIVER", "Failed to get interface")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask

  task drive(accu_trans req);
    vif.data_in <= req.data_in;
    vif.valid_in <= req.valid_in;
    @(posedge vif.clk);
  endtask

endclass

`endif