`ifndef ADDER_8BIT_TEST_SV
`define ADDER_8BIT_TEST_SV

class adder_8bit_test extends uvm_test;
    adder_8bit_env env;
    adder_8bit_sequence seq;

    `uvm_component_utils(adder_8bit_test)

    function new(string name = "adder_8bit_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = adder_8bit_env::type_id::create("env", this);
        seq = adder_8bit_sequence::type_id::create("seq", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info("TEST", "Simulation is starting.", UVM_LOW)
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass

`endif
