// test.sv
class fsm_test extends uvm_test; // Renamed test class to fsm_test
  `uvm_component_utils(fsm_test)

  environment env;
  fsm_sequence seq; 

  function new(string name = "fsm_test", uvm_component parent = null); // Updated class name in constructor
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
    seq = fsm_sequence::type_id::create("seq"); 
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agt.seq);
    phase.drop_objection(this);
  endtask
endclass