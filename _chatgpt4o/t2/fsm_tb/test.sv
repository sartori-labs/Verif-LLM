class fsm_test extends uvm_test;
  `uvm_component_utils(fsm_test)

  env_fsm env;
  seq_fsm seq;

  function new(string name = "fsm_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = env_fsm::type_id::create("env", this);
    seq = seq_fsm::type_id::create("seq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass
