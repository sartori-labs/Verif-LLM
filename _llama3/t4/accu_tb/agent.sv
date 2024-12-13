// accu_agent.sv
`ifndef ACCU_AGENT_SV
`define ACCU_AGENT_SV

class accu_agent extends uvm_agent;
  `uvm_component_utils(accu_agent)

  accu_sequencer sequencer;
  accu_driver driver;
  accu_monitor monitor;
  virtual accu_if vif;

  function new(string name = "accu_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = accu_sequencer::type_id::create("sequencer", this);
    driver = accu_driver::type_id::create("driver", this);
    monitor = accu_monitor::type_id::create("monitor", this);
    if (!uvm_config_db#(virtual accu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "failed to get virtual interface")
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    driver.vif = vif;
    monitor.vif = vif;
  endfunction

endclass

`endif
