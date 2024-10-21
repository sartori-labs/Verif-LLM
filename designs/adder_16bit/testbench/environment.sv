class adder_16bit_env extends uvm_env;
    // Make this environment more reusable
    `uvm_component_utils(adder_16bit_env)

    adder_16bit_agent agent;
    adder_16bit_scoreboard scoreboard;
    uvm_analysis_export #(adder_16bit_trans) analysis_export; // Add this line

    // This is the standard code for all components
    function new(string name = "adder_16bit_env", uvm_component parent = null);
        super.new(name, parent);   

        // Instantiate the analysis export port
        analysis_export = new("analysis_export", this); 
    endfunction : new

    // Build components here - agent, scoreboard, coverage
    virtual function void build_phase (uvm_phase phase);
        
        super.build_phase(phase);

        // Instantiate different agents and scoreboard here
        agent = adder_16bit_agent::type_id::create("agent", this);
        scoreboard = adder_16bit_scoreboard::type_id::create("scoreboard", this);

    endfunction : build_phase

    virtual function void connect_phase (uvm_phase phase);
        
        super.connect_phase(phase);
        
        // Connect the agent's monitor analysis port to the environment's analysis export
        agent.monitor.Mon2Sb_port.connect(analysis_export);

        // Connect the environment's analysis export to the scoreboard's analysis export
        analysis_export.connect(scoreboard.analysis_export); // Add this line

    endfunction : connect_phase

endclass