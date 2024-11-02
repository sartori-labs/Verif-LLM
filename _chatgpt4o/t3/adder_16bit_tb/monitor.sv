// UVM monitor class
class adder_16bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_16bit_monitor)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_trans) ap;

  function new(string name = "adder_16bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface not set for monitor")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      adder_16bit_trans trans = adder_16bit_trans::type_id::create("trans");
      @(posedge vif.clk);
      trans.a = vif.a;
      trans.b = vif.b;
      trans.Cin = vif.Cin;
      trans.y = vif.y;
      trans.Co = vif.Co;
      ap.write(trans);
    end
  endtask
endclass