class alu_environment extends uvm_env;
  `uvm_component_utils(alu_environment)

  alu_agent agent;
  alu_scoreboard scoreboard;
  uvm_analysis_port#(alu_trans) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = alu_agent::type_id::create("agent", this);
    scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
    ap = new("ap", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_port.connect(ap);
  endfunction
endclass