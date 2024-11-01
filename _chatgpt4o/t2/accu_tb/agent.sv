class accu_agent extends uvm_agent;
  `uvm_component_utils(accu_agent)

  accu_sequencer seqr;
  accu_driver drv;
  accu_monitor mon;
  virtual accu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = accu_sequencer::type_id::create("seqr", this);
    drv = accu_driver::type_id::create("drv", this);
    mon = accu_monitor::type_id::create("mon", this);

    if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif))
      `uvm_fatal("AGT", "Virtual interface not set for agent")

    drv.vif = vif;
    mon.vif = vif;
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
    mon.ap.connect(drv.ap);
  endfunction
endclass
