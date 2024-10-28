`ifndef ADDER_8BIT_ENV_SV
`define ADDER_8BIT_ENV_SV

class adder_8bit_env extends uvm_env;
    adder_8bit_agent agent;
    adder_8bit_scoreboard scoreboard;
    uvm_analysis_export #(adder_8bit_trans) analysis_export;

    `uvm_component_utils(adder_8bit_env)

    function new(string name = "adder_8bit_env", uvm_component parent = null);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = adder_8bit_agent::type_id::create("agent", this);
        scoreboard = adder_8bit_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agent.monitor.analysis_port.connect(analysis_export);
        analysis_export.connect(scoreboard.analysis_imp);
    endfunction
endclass

`endif
