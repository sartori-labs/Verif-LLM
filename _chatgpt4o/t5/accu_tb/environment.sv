// Environment class
class accu_env extends uvm_env;
    `uvm_component_utils(accu_env)

    accu_agent agent;
    accu_scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = accu_agent::type_id::create("agent", this);
        scoreboard = accu_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
    // Connect the monitor's analysis port to the scoreboard's analysis implementation
    agent.monitor.ap.connect(scoreboard.analysis_imp);
endfunction
endclass