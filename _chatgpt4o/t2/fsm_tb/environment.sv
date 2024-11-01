class env_fsm extends uvm_env;
  `uvm_component_utils(env_fsm)

  agent_fsm agent;
  scoreboard_fsm scoreboard;

  function new(string name = "env_fsm", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = agent_fsm::type_id::create("agent", this);
    scoreboard = scoreboard_fsm::type_id::create("scoreboard", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    agent.monitor.ap.connect(scoreboard.ap);
  endfunction
endclass
