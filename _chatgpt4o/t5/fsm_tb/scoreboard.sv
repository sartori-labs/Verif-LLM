`ifndef FSM_SCOREBOARD_SV
`define FSM_SCOREBOARD_SV

class fsm_scoreboard extends uvm_component;
    `uvm_component_utils(fsm_scoreboard)

    uvm_analysis_imp#(fsm_transaction, fsm_scoreboard) sb_port;

    function new(string name = "fsm_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        sb_port = new("sb_port", this);
    endfunction

    task write(fsm_transaction tr);
        bit expected_match;
        expected_match = compute_expected_match(tr.IN);
        if (tr.MATCH !== expected_match) begin
            `uvm_error("MISMATCH", $sformatf("Expected MATCH=%0b, got MATCH=%0b", expected_match, tr.MATCH));
        end
    endtask

    function bit compute_expected_match(bit IN);
        // Add logic for sequence check (1,0,0,1,1 pattern)
        // Placeholder logic; complete as per actual FSM requirements
        return (IN === 1); // Simple condition for illustration
    endfunction
endclass

`endif
