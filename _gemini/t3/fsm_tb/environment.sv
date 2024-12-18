// fsm_environment.sv
class fsm_environment extends uvm_env;
  `uvm_component_utils(fsm_environment)

  fsm_agent agt;
  fsm_scoreboard scb;

  function new(string name = "fsm_environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = fsm_agent::type_id::create("agt", this);
    scb = fsm_scoreboard::type_id::create("scb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.analysis_port.connect(scb.analysis_imp);
  endfunction
endclass