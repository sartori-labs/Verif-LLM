// Environment class
class accu_environment extends uvm_env;
    accu_agent agent;
    accu_scoreboard scoreboard;

    `uvm_component_utils(accu_environment)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = accu_agent::type_id::create("agent", this);
        scoreboard = accu_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.item_port.connect(scoreboard.item_port);
    endfunction
endclass