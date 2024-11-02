`ifndef FSM_ENV_SV
`define FSM_ENV_SV

class fsm_env extends uvm_env;
    `uvm_component_utils(fsm_env)

    fsm_agent agent;
    fsm_scoreboard sb;

    function new(string name = "fsm_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = fsm_agent::type_id::create("agent", this);
        sb = fsm_scoreboard::type_id::create("sb", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agent.mon.ap.connect(sb.sb_port);
    endfunction
endclass

`endif
