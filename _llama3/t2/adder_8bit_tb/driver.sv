// adder_8bit_driver.sv
class adder_8bit_driver extends uvm_driver #(adder_8bit_trans);
  `uvm_component_utils(adder_8bit_driver)

  virtual adder_8bit_if vif;

  function new(string name = "adder_8bit_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "failed to get vif")
  endfunction

  task run_phase(uvm_phase phase);
    adder_8bit_trans trans;
    forever begin
      seq_item_port.get_next_item(trans);
      `uvm_info("DRIVER", $sformatf("Driving transaction:\na=%h, b=%h, cin=%h", trans.a, trans.b, trans.cin), UVM_MEDIUM)
      vif.a <= trans.a;
      vif.b <= trans.b;
      vif.cin <= trans.cin;
      #10;
      seq_item_port.item_done();
    end
  endtask
endclass