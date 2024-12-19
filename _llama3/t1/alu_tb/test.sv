// Test class
class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)

  alu_environment environment;
  alu_sequence_item sequence_item;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    environment = alu_environment::type_id::create("environment", this);
    sequence_item = alu_sequence_item::type_id::create("sequence_item");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    sequence_item.start(environment.agent.sequencer);
    phase.drop_objection(this);
  endtask

endclass