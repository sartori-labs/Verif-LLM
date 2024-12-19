// Driver class
class alu_driver extends uvm_driver #(alu_trans);
  `uvm_component_utils(alu_driver)

  virtual interface alu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name()})
  endfunction

  task run_phase(uvm_phase phase);
    alu_trans trans;

    forever begin
      seq_item_port.get_next_item(trans);
      drive_item(trans);
      seq_item_port.item_done();
    end
  endtask

  task drive_item(alu_trans trans);
    @(posedge vif.clk);
    vif.a <= trans.a;
    vif.b <= trans.b;
    vif.aluc <= trans.aluc;
  endtask

endclass