// adder_16bit_env.sv
`ifndef ADDER_16BIT_ENV_SV
`define ADDER_16BIT_ENV_SV

class adder_16bit_env extends uvm_env;
    `uvm_component_utils(adder_16bit_env)

    adder_16bit_agent agent;
    adder_16bit_scoreboard sb;

    function new(string name = "adder_16bit_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = adder_16bit_agent::type_id::create("agent", this);
        sb = adder_16bit_scoreboard::type_id::create("sb", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agent.mon.ap.connect(sb.analysis_imp);
    endfunction
endclass

`endif // ADDER_16BIT_ENV_SV
