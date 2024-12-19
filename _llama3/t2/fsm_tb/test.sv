// Test class
class fsm_test extends uvm_test;
  `uvm_component_utils(fsm_test)

  fsm_environment environment;
  fsm_sequence seq; // Renamed from "sequence" to "seq"

  function new(string name = "fsm_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    environment = fsm_environment::type_id::create("environment", this);
    seq = fsm_sequence::type_id::create("seq"); // Updated variable name
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(environment.agent.sequencer); // Updated variable name
    phase.drop_objection(this);
  endtask
endclass