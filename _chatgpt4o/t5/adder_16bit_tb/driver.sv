// adder_driver.sv
class adder_driver extends uvm_driver #(adder_transaction);
  `uvm_component_utils(adder_driver)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("adder_driver", "Virtual interface not set")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_transaction trans;
      seq_item_port.get_next_item(trans);

      vif.a <= trans.a;
      vif.b <= trans.b;
      vif.Cin <= trans.Cin;

      // Wait for the DUT to process the transaction
      wait(vif.Co !== 'x);

      trans.y = vif.y;
      trans.Co = vif.Co;

      ap.write(trans);
      seq_item_port.item_done();
    end
  endtask
endclass
