class adder_8bit_test extends uvm_test;

    adder_8bit_env env;
    adder_8bit_sequence seq;

    `uvm_component_utils(adder_8bit_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = adder_8bit_env::type_id::create("env", this);
        seq = adder_8bit_sequence::type_id::create("seq");
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask

endclass
