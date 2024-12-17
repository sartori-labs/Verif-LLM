// adder_8bit_agent.sv
class adder_8bit_agent extends uvm_agent;
  `uvm_component_utils(adder_8bit_agent)

  uvm_sequencer #(adder_8bit_transaction) seqr;
  adder_8bit_driver driver;
  adder_8bit_monitor monitor;

  function new(string name = "adder_8bit_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = uvm_sequencer #(adder_8bit_transaction)::type_id::create("seqr", this);
    driver = adder_8bit_driver::type_id::create("driver", this);
    monitor = adder_8bit_monitor::type_id::create("monitor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass
