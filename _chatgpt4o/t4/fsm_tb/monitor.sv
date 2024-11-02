// Monitor class
class fsm_monitor extends uvm_monitor;
  `uvm_component_utils(fsm_monitor)

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
      `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
    end
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
    fsm_transaction tr;
    forever begin
      @(posedge vif.CLK);
      tr = fsm_transaction::type_id::create("tr");
      tr.IN = vif.IN;
      tr.MATCH = vif.MATCH;
      ap.write(tr);
    end
  endtask
endclass
