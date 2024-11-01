class agent_fsm extends uvm_agent;
  `uvm_component_utils(agent_fsm)

  sequencer_fsm sequencer;
  driver_fsm driver;
  monitor_fsm monitor;
  virtual fsm_if vif;

  function new(string name = "agent_fsm", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = sequencer_fsm::type_id::create("sequencer", this);
    driver = driver_fsm::type_id::create("driver", this);
    monitor = monitor_fsm::type_id::create("monitor", this);

    if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")

    driver.vif = vif;
    monitor.vif = vif;
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass
