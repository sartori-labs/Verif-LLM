// Environment class
class fsm_environment extends uvm_env;
  `uvm_component_utils(fsm_environment)

  fsm_agent agent;
  fsm_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = fsm_agent::type_id::create("agent", this);
    scoreboard = fsm_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_collected_port.connect(scoreboard.act_port);
  endfunction

endclass