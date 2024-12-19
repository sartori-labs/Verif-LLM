// adder_8bit_environment.sv
class adder_8bit_environment extends uvm_env;
  `uvm_component_utils(adder_8bit_environment)

  adder_8bit_agent agent;
  adder_8bit_scoreboard scoreboard;

  function new(string name = "adder_8bit_environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = adder_8bit_agent::type_id::create("agent", this);
    scoreboard = adder_8bit_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_collected_port.connect(scoreboard.analysis_imp);
  endfunction
endclass