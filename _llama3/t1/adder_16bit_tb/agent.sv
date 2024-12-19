// Agent class
class adder_16bit_agent extends uvm_agent;
  `uvm_component_utils(adder_16bit_agent)

  adder_16bit_sequencer sequencer;
  adder_16bit_driver driver;
  adder_16bit_monitor monitor;

  virtual adder_16bit_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = adder_16bit_sequencer::type_id::create("sequencer", this);
    driver = adder_16bit_driver::type_id::create("driver", this);
    monitor = adder_16bit_monitor::type_id::create("monitor", this);

    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "failed to get virtual interface")
    end

    uvm_config_db#(virtual adder_16bit_if)::set(this, "driver", "vif", vif);
    uvm_config_db#(virtual adder_16bit_if)::set(this, "monitor", "vif", vif);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass