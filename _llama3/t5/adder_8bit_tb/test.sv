class adder_8bit_test extends uvm_test;
  `uvm_component_utils(adder_8bit_test)

  adder_8bit_environment environment;
  adder_8bit_sequence adder_seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    environment = adder_8bit_environment::type_id::create("environment", this);
    adder_seq = adder_8bit_sequence::type_id::create("adder_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    adder_seq.start(environment.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass