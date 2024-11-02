// Driver class
class fsm_driver extends uvm_driver #(fsm_transaction);
  `uvm_component_utils(fsm_driver)

  virtual fsm_if vif;
  uvm_analysis_port #(fsm_transaction) ap;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  // Build phase to set virtual interface
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for driver")
    end
  endfunction

  // Main run phase
  virtual task run_phase(uvm_phase phase);
    fsm_transaction tr;
    forever begin
      seq_item_port.get_next_item(tr);
      vif.IN <= tr.IN;
      @(posedge vif.CLK);
      tr.MATCH = vif.MATCH;  // Capturing output for analysis
      ap.write(tr);
      seq_item_port.item_done();
    end
  endtask
endclass
