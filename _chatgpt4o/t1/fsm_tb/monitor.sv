// Monitor class
class fsm_monitor extends uvm_monitor;
  `uvm_component_utils(fsm_monitor)

  virtual fsm_if vif; // Virtual interface
  uvm_analysis_port #(fsm_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      fsm_transaction tx = fsm_transaction::type_id::create("tx");
      @(posedge vif.CLK);
      tx.IN = vif.IN;
      tx.MATCH = vif.MATCH;
      ap.write(tx);
    end
  endtask
endclass