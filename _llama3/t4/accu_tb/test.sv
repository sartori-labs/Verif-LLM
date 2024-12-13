// accu_test.sv
`ifndef ACCU_TEST_SV
`define ACCU_TEST_SV

class accu_test extends uvm_test;
  `uvm_component_utils(accu_test)

  accu_environment environment;
  accu_sequence seq;

  function new(string name = "accu_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    environment = accu_environment::type_id::create("environment", this);
    seq = accu_sequence::type_id::create("seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(environment.agent.sequencer);
    phase.drop_objection(this);
  endtask

endclass

`endif
