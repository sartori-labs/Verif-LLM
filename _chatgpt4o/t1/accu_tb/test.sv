// Test Class
class accu_test extends uvm_test;
    `uvm_component_utils(accu_test)

    accu_env env;
    accu_sequence seq;

    // Constructor
    function new(string name = "accu_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = accu_env::type_id::create("env", this);
        seq = accu_sequence::type_id::create("seq");
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass
