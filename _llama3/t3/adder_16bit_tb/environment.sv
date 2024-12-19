// Environment class
class adder_16bit_environment extends uvm_env;
    `uvm_component_utils(adder_16bit_environment)

    adder_16bit_agent agent;
    adder_16bit_scoreboard scoreboard;
    uvm_analysis_port #(adder_16bit_trans) item_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_port = new("item_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = adder_16bit_agent::type_id::create("agent", this);
        scoreboard = adder_16bit_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.item_collected_port.connect(item_port);
        item_port.connect(scoreboard.item_imp);
    endfunction
endclass