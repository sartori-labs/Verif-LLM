class alu_env extends uvm_env;
    `uvm_component_utils(alu_env)

    alu_agent agt;
    alu_scoreboard sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = alu_agent::type_id::create("agt", this);
        sb = alu_scoreboard::type_id::create("sb", this);

        if (agt == null || sb == null) begin
            `uvm_fatal("ENV", "Agent or scoreboard not properly created.")
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect monitor's analysis port to scoreboard
        agt.mon.ap.connect(sb.analysis_port);
    endfunction
endclass
