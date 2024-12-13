// Test class
class accu_test extends uvm_test;
    accu_environment environment;
    accu_sequence accu_seq;

    `uvm_component_utils(accu_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = accu_environment::type_id::create("environment", this);
        accu_seq = accu_sequence::type_id::create("accu_seq");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        accu_seq.start(environment.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass