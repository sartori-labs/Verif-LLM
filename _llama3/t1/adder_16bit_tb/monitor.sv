// Monitor class
class adder_16bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_16bit_monitor)

  virtual adder_16bit_if vif;

  uvm_analysis_port #(adder_16bit_trans) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "failed to get virtual interface")
    end
  endfunction

  task run_phase(uvm_phase phase);
    adder_16bit_trans trans;
    forever begin
      @(posedge vif.clk);
      trans = adder_16bit_trans::type_id::create("trans");
      trans.a = vif.a;
      trans.b = vif.b;
      trans.Cin = vif.Cin;
      trans.y = vif.y;
      trans.Co = vif.Co;
      item_collected_port.write(trans);
    end
  endtask
endclass