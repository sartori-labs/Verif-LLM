// Driver class
class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)

  virtual alu_if vif; // Virtual interface

  function new(string name = "alu_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "Virtual interface not set for alu_driver")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      alu_transaction tr;
      seq_item_port.get_next_item(tr);

      // Drive signals to DUT
      vif.a = tr.a;
      vif.b = tr.b;
      vif.aluc = tr.aluc;
      // Wait for a clock cycle to sample results
      @(posedge vif.clk);
      // Capture output
      tr.r = vif.r;
      tr.zero = vif.zero;
      tr.carry = vif.carry;
      tr.negative = vif.negative;
      tr.overflow = vif.overflow;
      tr.flag = vif.flag;

      seq_item_port.item_done();
    end
  endtask
endclass