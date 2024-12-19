// Driver class
class adder_16bit_driver extends uvm_driver #(adder_16bit_trans);
  `uvm_component_utils(adder_16bit_driver)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_trans) driver_ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    driver_ap = new("driver_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "failed to get virtual interface")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      @(posedge vif.clk);
      vif.a <= req.a;
      vif.b <= req.b;
      vif.Cin <= req.Cin;
      req.y = vif.y;
      req.Co = vif.Co;
      driver_ap.write(req);
      seq_item_port.item_done();
    end
  endtask
endclass
