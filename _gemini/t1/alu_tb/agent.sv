// alu_agent.sv
class alu_agent extends uvm_agent;
  `uvm_component_utils(alu_agent)

  alu_sequencer  #(alu_transaction) sequencer;
  alu_driver     #(alu_transaction) driver;
  alu_monitor    monitor;

  virtual alu_if vif;

  function new(string name = "alu_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = alu_sequencer  #(alu_transaction)::type_id::create("sequencer", this);
    driver    = alu_driver     #(alu_transaction)::type_id::create("driver", this);
    monitor   = alu_monitor    ::type_id::create("monitor", this);

    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("ALU_AGENT", "Virtual interface not found")
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass