class monitor_fsm extends uvm_monitor;
  `uvm_component_utils(monitor_fsm)

  virtual fsm_if vif;
  uvm_analysis_port #(trans_fsm) ap;

  function new(string name = "monitor_fsm", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    trans_fsm tr;
    forever begin
      @(posedge vif.CLK);
      tr = trans_fsm::type_id::create("tr");
      tr.IN = vif.IN;
      tr.MATCH = vif.MATCH;
      ap.write(tr);
    end
  endtask
endclass
