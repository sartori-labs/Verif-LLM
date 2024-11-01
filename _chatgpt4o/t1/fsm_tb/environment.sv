// Environment class
class fsm_env extends uvm_env;
  `uvm_component_utils(fsm_env)

  fsm_agent agent;
  fsm_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent = fsm_agent::type_id::create("agent", this);
    scoreboard = fsm_scoreboard::type_id::create("scoreboard", this);

    // Connect monitor's analysis port to scoreboard
    agent.monitor.ap.connect(scoreboard.ap);
  endfunction
endclass