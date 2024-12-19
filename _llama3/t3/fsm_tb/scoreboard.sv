class fsm_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fsm_scoreboard)

    uvm_analysis_imp #(fsm_trans, fsm_scoreboard) sb_export;
    fsm_trans expected_trans;
    fsm_trans actual_trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        sb_export = new("sb_export", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void write(fsm_trans trans);
        actual_trans = trans;
        check_result();
    endfunction

    function void check_result();
        // Calculate expected result based on FSM logic
        expected_trans.MATCH = (actual_trans.IN == 1) && ((actual_trans.IN === 1) === (expected_trans.IN === 1));

        if (expected_trans != actual_trans) begin
            `uvm_error("SB_ERROR", $sformatf("Expected MATCH=%0d, Actual MATCH=%0d", expected_trans.MATCH, actual_trans.MATCH));
        end
    endfunction
endclass