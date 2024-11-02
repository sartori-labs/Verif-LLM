// fsm_monitor.sv
class fsm_monitor extends uvm_monitor;
  `uvm_component_utils(fsm_monitor)

  virtual fsm_if vif;
  uvm_analysis_port #(fsm_transaction) ap;

  function new(string name = "fsm_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      // Create transaction before posedge CLK
      fsm_transaction tr = fsm_transaction::type_id::create("tr", this);
      
      @(posedge vif.CLK);  // Wait for the positive edge of CLK
      // Sample inputs and outputs after the clock edge
      tr.IN = vif.IN;
      tr.MATCH = vif.MATCH;
      
      // Send the transaction to the analysis port
      ap.write(tr);
    end
  endtask
endclass
