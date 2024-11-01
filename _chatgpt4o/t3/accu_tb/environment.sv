// UVM Environment Class
class accu_env extends uvm_env;
    `uvm_component_utils(accu_env)

    accu_agent agt;
    accu_scoreboard sb;

    function new(string name = "accu_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = accu_agent::type_id::create("agt", this);
        sb = accu_scoreboard::type_id::create("sb", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.mon.ap.connect(sb.ap);
    endfunction
endclass