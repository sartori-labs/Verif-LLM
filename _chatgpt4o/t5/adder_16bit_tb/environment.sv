// adder_env.sv
class adder_env extends uvm_env;
  `uvm_component_utils(adder_env)

  adder_agent agent;
  adder_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = adder_agent::type_id::create("agent", this);
    scoreboard = adder_scoreboard::type_id::create("scoreboard", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    agent.monitor.ap.connect(scoreboard.imp);
  endfunction
endclass
