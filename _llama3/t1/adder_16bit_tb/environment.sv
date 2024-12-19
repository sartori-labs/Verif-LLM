// Environment class
class adder_16bit_environment extends uvm_env;
  `uvm_component_utils(adder_16bit_environment)

  adder_16bit_agent agent;
  adder_16bit_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = adder_16bit_agent::type_id::create("agent", this);
    scoreboard = adder_16bit_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.driver.driver_ap.connect(scoreboard.sb_imp);
  endfunction
endclass