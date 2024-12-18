// fsm_scoreboard.sv
class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp #(fsm_transaction, fsm_scoreboard) analysis_imp;
  typedef enum { S0, S1, S2, S3, S4 } state_t;
  state_t current_state;

  function new(string name = "fsm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    current_state = S0; // Initialize state
  endfunction

  function void write(fsm_transaction trans);
    // Scoreboard logic to compute expected MATCH and compare with trans.MATCH
    bit expected_MATCH = 0; 
    case (current_state)
      S0: if (trans.IN) current_state = S1;
      S1: if (!trans.IN) current_state = S2;
      S2: if (!trans.IN) current_state = S3;
      S3: if (trans.IN) current_state = S4;
      S4: begin
        if (trans.IN) begin
          expected_MATCH = 1;
          current_state = S1;
        end else
          current_state = S0;
      end
    endcase

    if (trans.MATCH !== expected_MATCH) begin
      `uvm_error("fsm_scoreboard", $sformatf("Mismatch: expected MATCH = %0b, actual MATCH = %0b", 
                                         expected_MATCH, trans.MATCH))
    end
  endfunction
endclass