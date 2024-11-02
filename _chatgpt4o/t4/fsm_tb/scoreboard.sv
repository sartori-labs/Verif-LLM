// Scoreboard class
class fsm_scoreboard extends uvm_component;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp #(fsm_transaction, fsm_scoreboard) sb_port;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    sb_port = new("sb_port", this);
  endfunction

  // Write method
  function void write(fsm_transaction tr);
    bit expected_MATCH;
    
    // Logic for expected output MATCH based on input sequence
    // This logic should match the FSM design specification

    // Compare expected output with DUT output
    if (expected_MATCH !== tr.MATCH) begin
      `uvm_error("MISMATCH", $sformatf("Mismatch: IN=%b, Expected MATCH=%b, DUT MATCH=%b",
                                        tr.IN, expected_MATCH, tr.MATCH))
    end
  endfunction
endclass