// fsm_scoreboard.sv
class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp #(fsm_transaction, fsm_scoreboard) analysis_imp;
  int state;
  int expected_match; // To store the expected MATCH value

  function new(string name = "fsm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    state = 0; // Initialize to the initial state (S0)
  endfunction

  function void write(fsm_transaction trans);
    // This function is called by the analysis_imp when a transaction is received

    // Scoreboard logic to compute expected MATCH and compare with trans.MATCH
    case (state)
      0: begin // S0
        expected_match = 0; // MATCH should be 0 in S0
        if (trans.IN) 
          state = 1; 
      end
      1: begin // S1
        expected_match = 0; // MATCH should be 0 in S1
        if (!trans.IN) 
          state = 2; 
      end
      2: begin // S2
        expected_match = 0; // MATCH should be 0 in S2
        if (!trans.IN) 
          state = 3; 
      end
      3: begin // S3
        expected_match = 0; // MATCH should be 0 in S3
        if (trans.IN) 
          state = 4; 
      end
      4: begin // S4
        if (trans.IN) begin
          expected_match = 1; // MATCH should be 1 in S4 when IN is 1
          state = 1; 
        end else begin
          expected_match = 0; // MATCH should be 0 in S4 when IN is 0
          state = 0;
        end
      end
    endcase

    // Compare expected_match with the actual MATCH from DUT
    if (trans.MATCH !== expected_match)
      `uvm_error("Scoreboard", $sformatf("Mismatch at time %t: Expected MATCH = %0b, Actual MATCH = %0b", $time, expected_match, trans.MATCH));
  endfunction
endclass