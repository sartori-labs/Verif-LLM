// Monitor class
class adder_8bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_8bit_monitor)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_trans) item_port;

  function new(string name = "adder_8bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_port = new("item_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    adder_8bit_trans trans;
    forever begin
      @(posedge vif.clk);
      trans = adder_8bit_trans::type_id::create("trans");
      trans.a = vif.a;
      trans.b = vif.b;
      trans.cin = vif.cin;
      trans.sum = vif.sum;
      trans.cout = vif.cout;
      item_port.write(trans);
    end
  endtask
endclass