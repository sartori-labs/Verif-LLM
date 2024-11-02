// adder_agent.sv
class adder_agent extends uvm_agent;
  `uvm_component_utils(adder_agent)

  adder_sequencer sequencer;
  adder_driver driver;
  adder_monitor monitor;
  virtual adder_16bit_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("adder_agent", "Virtual interface not set")
    end

    sequencer = adder_sequencer::type_id::create("sequencer", this);
    driver = adder_driver::type_id::create("driver", this);
    monitor = adder_monitor::type_id::create("monitor", this);

    driver.vif = vif;
    monitor.vif = vif;
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass
