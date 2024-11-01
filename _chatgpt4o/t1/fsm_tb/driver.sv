// Driver class
class fsm_driver extends uvm_driver #(fsm_transaction);
  `uvm_component_utils(fsm_driver)

  virtual fsm_if vif; // Virtual interface
  uvm_analysis_port #(fsm_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      fsm_transaction tx;
      seq_item_port.get_next_item(tx);

      // Apply transaction to DUT
      vif.IN = tx.IN;
      @(posedge vif.CLK); // Wait for positive edge of the clock
      ap.write(tx);

      seq_item_port.item_done();
    end
  endtask
endclass