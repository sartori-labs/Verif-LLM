// Environment class
class adder_16bit_env extends uvm_env;
    `uvm_component_utils(adder_16bit_env)

    adder_16bit_agent agent;
    adder_16bit_scoreboard scoreboard;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = adder_16bit_agent::type_id::create("agent", this);
        scoreboard = adder_16bit_scoreboard::type_id::create("scoreboard", this);
    endfunction

    // Connect phase
    function void connect_phase(uvm_phase phase);
        agent.monitor.analysis_port.connect(scoreboard.analysis_imp);
    endfunction
endclass
