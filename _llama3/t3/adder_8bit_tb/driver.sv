// Driver class
class adder_8bit_driver extends uvm_driver #(adder_8bit_trans);
  `uvm_component_utils(adder_8bit_driver)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_trans) item_port;

  function new(string name = "adder_8bit_driver", uvm_component parent = null);
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
      seq_item_port.get_next_item(trans);
      drive_item(trans);
      item_port.write(trans);
      seq_item_port.item_done();
    end
  endtask

  task drive_item(adder_8bit_trans trans);
    @(posedge vif.clk);
    vif.a <= trans.a;
    vif.b <= trans.b;
    vif.cin <= trans.cin;
  endtask
endclass