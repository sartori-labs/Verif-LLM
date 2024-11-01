// Test class
class adder_16bit_test extends uvm_test;
    `uvm_component_utils(adder_16bit_test)

    adder_16bit_env env;
    adder_16bit_sequence seq;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = adder_16bit_env::type_id::create("env", this);
        seq = adder_16bit_sequence::type_id::create("seq");
    endfunction

    // Run phase
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info("TEST", "Starting test...", UVM_LOW)
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass
