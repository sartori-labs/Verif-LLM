// Agent class
class fsm_agent extends uvm_agent;
  `uvm_component_utils(fsm_agent)

  fsm_sequencer seqr;
  fsm_driver drv;
  fsm_monitor mon;
  virtual fsm_if vif;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = fsm_sequencer::type_id::create("seqr", this);
    drv = fsm_driver::type_id::create("drv", this);
    mon = fsm_monitor::type_id::create("mon", this);

    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for agent")
    end

    drv.vif = vif;
    mon.vif = vif;
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
    drv.ap.connect(mon.ap);
  endfunction
endclass
