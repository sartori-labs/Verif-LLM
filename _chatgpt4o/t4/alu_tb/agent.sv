// Agent class with added connect_phase
class alu_agent extends uvm_agent;
  `uvm_component_utils(alu_agent)

  alu_sequencer seqr;
  alu_driver drv;
  alu_monitor mon;
  virtual alu_if vif;

  function new(string name = "alu_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = alu_sequencer::type_id::create("seqr", this);
    drv = alu_driver::type_id::create("drv", this);
    mon = alu_monitor::type_id::create("mon", this);

    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("AGT", "Virtual interface not set for alu_agent")
    end
    drv.vif = vif;
    mon.vif = vif;
  endfunction

  function void connect_phase(uvm_phase phase);
    // Connecting the sequencer to the driver
    drv.seq_item_port.connect(seqr.seq_item_export);
    // Analysis port connection in monitor already connects to the scoreboard via environment
  endfunction
endclass
