// agent.sv
class agent extends uvm_agent;
  `uvm_component_utils(agent)

  sequencer seq;
  driver drv;
  monitor mon;

  virtual fsm_if vif;

  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = sequencer::type_id::create("seq", this);
    drv = driver::type_id::create("drv", this);
    mon = monitor::type_id::create("mon", this);

    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_error("AGENT", "Virtual interface not found")
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seq.seq_item_export);
  endfunction
endclass