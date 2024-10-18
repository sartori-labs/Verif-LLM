class adder_8bit_test extends uvm_test;
    // Make this test more reusable
    `uvm_component_utils(adder_8bit_test)

    adder_8bit_env env;
    // Create and start the sequence
    adder_8bit_sequence seq;
       
    // This is the standard code for all components
    function new (string name = "adder_8bit_test", uvm_component parent = null);
        super.new(name, parent);    
    endfunction : new

    // Declare other testbench components - environment, configuration

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);

        // Instantiate components usign "type_id::create()" method instead of new()
        env = adder_8bit_env::type_id::create("env", this);
        seq = adder_8bit_sequence::type_id::create("seq");

    endfunction : build_phase

    // By this phase, the environment is all set up so print the topology for debug
    virtual function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

    function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
    endfunction : start_of_simulation_phase

    virtual task run_phase (uvm_phase phase);

        super.run_phase(phase);

        // Raise objection - else this test will not consume simulation time
        phase.raise_objection(this, "Starting Test");
        
        // Start the sequence on the sequencer
        if (seq != null) begin
            seq.start(env.agent.sequencer);
        end else begin
            `uvm_error("RUN_PHASE", "Failed to create sequence")
        end

        // Drop objection - else this test will not finish
        phase.drop_objection(this, "Ending Test");
    endtask : run_phase
    
endclass