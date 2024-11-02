// fsm_env.sv
class fsm_env extends uvm_env;
  `uvm_component_utils(fsm_env)

  fsm_agent agent;
  fsm_scoreboard scoreboard;

  function new(string name = "fsm_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = fsm_agent::type_id::create("agent", this);
    scoreboard = fsm_scoreboard::type_id::create("scoreboard", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    agent.monitor.ap.connect(scoreboard.ap);
  endfunction
endclass
