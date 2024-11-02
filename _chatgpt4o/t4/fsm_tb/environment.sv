// Environment class
class fsm_env extends uvm_env;
  `uvm_component_utils(fsm_env)

  fsm_agent agt;
  fsm_scoreboard sb;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = fsm_agent::type_id::create("agt", this);
    sb = fsm_scoreboard::type_id::create("sb", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.ap.connect(sb.sb_port);
  endfunction
endclass
