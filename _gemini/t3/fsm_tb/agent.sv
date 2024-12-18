// fsm_agent.sv
class fsm_agent extends uvm_agent;
  `uvm_component_utils(fsm_agent)

  fsm_sequencer seq;
  fsm_driver drv;
  fsm_monitor mon;

  virtual fsm_if vif;

  function new(string name = "fsm_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = fsm_sequencer::type_id::create("seq", this);
    drv = fsm_driver::type_id::create("drv", this);
    mon = fsm_monitor::type_id::create("mon", this);

    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_error("AGENT", "Virtual interface not found")
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seq.seq_item_export);
  endfunction
endclass
