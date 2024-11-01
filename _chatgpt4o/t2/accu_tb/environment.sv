class accu_env extends uvm_env;
  `uvm_component_utils(accu_env)

  accu_agent agt;
  accu_scoreboard sb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = accu_agent::type_id::create("agt", this);
    sb = accu_scoreboard::type_id::create("sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    agt.mon.ap.connect(sb.ap);
  endfunction
endclass
