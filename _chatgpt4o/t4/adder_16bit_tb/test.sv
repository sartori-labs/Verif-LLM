// adder_16bit_test.sv
class adder_16bit_test extends uvm_test;
  `uvm_component_utils(adder_16bit_test)

  adder_16bit_env env;
  adder_16bit_seq seq;

  function new(string name = "adder_16bit_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = adder_16bit_env::type_id::create("env", this);
    seq = adder_16bit_seq::type_id::create("seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass