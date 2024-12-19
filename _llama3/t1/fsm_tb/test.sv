class fsm_test extends uvm_test;
  `uvm_component_utils(fsm_test)

  fsm_environment env;
  fsm_sequence seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fsm_environment::type_id::create("env", this);
    seq = fsm_sequence::type_id::create("seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass