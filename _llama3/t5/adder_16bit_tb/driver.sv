// Driver class
class adder_16bit_driver extends uvm_driver#(adder_16bit_trans);
  `uvm_component_utils(adder_16bit_driver)

  virtual adder_16bit_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    end
  endfunction

  task run_phase(uvm_phase phase);
    adder_16bit_trans trans;
    forever begin
      seq_item_port.get_next_item(trans);
      drive(trans);
      seq_item_port.item_done();
    end
  endtask

  task drive(adder_16bit_trans trans);
    vif.a <= trans.a;
    vif.b <= trans.b;
    vif.Cin <= trans.Cin;
    @(posedge vif.clk);
    trans.y = vif.y;
    trans.Co = vif.Co;
  endtask
endclass