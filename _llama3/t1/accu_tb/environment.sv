// Environment class
class accu_environment extends uvm_env;
  `uvm_component_utils(accu_environment)

  accu_agent agent;
  accu_scoreboard scoreboard;

  function new(string name = "accu_environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = accu_agent::type_id::create("agent", this);
    scoreboard = accu_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_collected_port.connect(scoreboard.item_collected_export);
  endfunction
endclass
