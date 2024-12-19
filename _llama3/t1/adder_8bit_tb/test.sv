// Test class
class adder_8bit_test extends uvm_test;
    `uvm_component_utils(adder_8bit_test)

    adder_8bit_environment environment;
    adder_8bit_sequence seq_item;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = adder_8bit_environment::type_id::create("environment", this);
        seq_item = adder_8bit_sequence::type_id::create("seq_item");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq_item.start(environment.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass