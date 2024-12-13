// accu_driver.sv
`ifndef ACCU_DRIVER_SV
`define ACCU_DRIVER_SV

class accu_driver extends uvm_driver#(accu_trans);
  `uvm_component_utils(accu_driver)

  virtual accu_if vif;

  function new(string name = "accu_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual accu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "failed to get virtual interface")
    end
  endfunction

  task run_phase(uvm_phase phase);
    accu_trans trans;
    forever begin
      seq_item_port.get_next_item(trans);
      drive_item(trans);
      seq_item_port.item_done();
    end
  endtask

  task drive_item(accu_trans trans);
    vif.data_in <= trans.data_in;
    vif.valid_in <= trans.valid_in;
    @(posedge vif.clk);
  endtask

endclass

`endif
