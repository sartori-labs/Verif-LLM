// Test class
class adder_16bit_test extends uvm_test;
    `uvm_component_utils(adder_16bit_test)

    adder_16bit_environment environment;
    adder_16bit_sequence seq_item; // Renamed variable

    function new(string name = "adder_16bit_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = adder_16bit_environment::type_id::create("environment", this);
        seq_item = adder_16bit_sequence::type_id::create("seq_item"); // Renamed variable
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq_item.start(environment.agent.sequencer); // Renamed variable
        phase.drop_objection(this);
    endtask

endclass