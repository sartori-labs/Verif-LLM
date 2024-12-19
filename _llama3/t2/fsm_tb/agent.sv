// Agent class
class fsm_agent extends uvm_agent;
  `uvm_component_utils(fsm_agent)

  fsm_sequencer sequencer;
  fsm_driver driver;
  fsm_monitor monitor;

  virtual fsm_if vif;

  function new(string name = "fsm_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = fsm_sequencer::type_id::create("sequencer", this);
    driver = fsm_driver::type_id::create("driver", this);
    monitor = fsm_monitor::type_id::create("monitor", this);
    if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    monitor.item_collected_port.connect(driver.analysis_export);
  endfunction
endclass