// adder_8bit_driver.sv
class adder_8bit_driver extends uvm_driver #(adder_8bit_transaction);
  `uvm_component_utils(adder_8bit_driver)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_transaction) analysis_port;

  function new(string name = "adder_8bit_driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("ADDER_DRV", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.a <= req.a;
      vif.b <= req.b;
      vif.cin <= req.cin;
      #10; // Wait for some time for the DUT to process
      analysis_port.write(req);
      seq_item_port.item_done();
    end
  endtask
endclass