// Environment class
class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)

  alu_agent agt;
  alu_scoreboard sb;

  function new(string name = "alu_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = alu_agent::type_id::create("agt", this);
    sb = alu_scoreboard::type_id::create("sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    agt.mon.ap.connect(sb.sb_ap);
  endfunction
endclass