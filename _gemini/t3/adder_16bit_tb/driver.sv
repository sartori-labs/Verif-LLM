// adder_16bit_driver.sv
class adder_16bit_driver extends uvm_driver #(adder_16bit_transaction);
  `uvm_component_utils(adder_16bit_driver)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_transaction) analysis_port;

  function new(string name = "adder_16bit_driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("ADDER_DRV", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.a <= req.a;
      vif.b <= req.b;
      vif.Cin <= req.Cin;
      #10; // Wait for some time for the DUT to process
      analysis_port.write(req);
      seq_item_port.item_done();
    end
  endtask
endclass