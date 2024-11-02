// adder_16bit_driver.sv
class adder_16bit_driver extends uvm_driver #(adder_16bit_txn);
  `uvm_component_utils(adder_16bit_driver)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_txn) ap;

  function new(string name = "adder_16bit_driver", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      adder_16bit_txn txn;
      seq_item_port.get_next_item(txn);
      vif.a = txn.a;
      vif.b = txn.b;
      vif.Cin = txn.Cin;
      #1; // Wait for outputs to be stable
      txn.y = vif.y;
      txn.Co = vif.Co;
      ap.write(txn);
      seq_item_port.item_done();
    end
  endtask
endclass