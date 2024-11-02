// adder_16bit_test.sv
class adder_16bit_test extends uvm_test;
  `uvm_component_utils(adder_16bit_test)

  adder_env env;
  adder_sequence seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = adder_env::type_id::create("env", this);
    seq = adder_sequence::type_id::create("seq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass
