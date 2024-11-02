// Test class
class fsm_test extends uvm_test;
  `uvm_component_utils(fsm_test)

  fsm_env env;
  fsm_sequence seq;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fsm_env::type_id::create("env", this);
    seq = fsm_sequence::type_id::create("seq");
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass