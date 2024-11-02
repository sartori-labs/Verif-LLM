// UVM driver class
class adder_16bit_driver extends uvm_driver #(adder_16bit_trans);
  `uvm_component_utils(adder_16bit_driver)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_trans) ap;

  function new(string name = "adder_16bit_driver", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "Virtual interface not set for driver")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      adder_16bit_trans trans;
      seq_item_port.get_next_item(trans);
      vif.a = trans.a;
      vif.b = trans.b;
      vif.Cin = trans.Cin;
      @(posedge vif.clk);
      trans.y = vif.y;
      trans.Co = vif.Co;
      ap.write(trans);
      seq_item_port.item_done();
    end
  endtask
endclass