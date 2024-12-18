// alu_env.sv
class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)

  alu_agent agent;
  alu_scoreboard scoreboard;

  function new(string name = "alu_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = alu_agent::type_id::create("agent", this);
    scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.analysis_port.connect(scoreboard.analysis_imp);
  endfunction
endclass
