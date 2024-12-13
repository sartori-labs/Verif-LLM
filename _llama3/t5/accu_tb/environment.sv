// accu_environment.sv
`ifndef ACCU_ENVIRONMENT_SV
`define ACCU_ENVIRONMENT_SV

class accu_environment extends uvm_env;
  `uvm_component_utils(accu_environment)

  accu_agent agent;
  accu_scoreboard scoreboard;
  uvm_tlm_analysis_fifo#(accu_trans) fifo;
  uvm_analysis_port#(accu_trans) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = accu_agent::type_id::create("agent", this);
    scoreboard = accu_scoreboard::type_id::create("scoreboard", this);
    fifo = new("fifo", this);
    ap = new("ap", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_collected_port.connect(fifo.analysis_export);
    fifo.analysis_export.connect(ap);
    ap.connect(scoreboard.item_collected_export);
  endfunction

endclass

`endif