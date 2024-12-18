// scoreboard.sv
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(transaction, scoreboard) analysis_imp;

  typedef enum { S0, S1, S2, S3, S4 } state_t;
  state_t current_state;

  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    current_state = S0; // Initialize state
  endfunction

  function void write(transaction trans);
    logic expected_match;
    // Scoreboard logic to compute expected MATCH
    case (current_state)
      S0: if (trans.IN) current_state = S1;
      S1: if (!trans.IN) current_state = S2;
      S2: if (!trans.IN) current_state = S3;
      S3: if (trans.IN) current_state = S4;
      S4: begin
        if (trans.IN) begin
          current_state = S1;
          expected_match = 1;
        end else begin
          current_state = S0;
        end
      end
    endcase

    if (trans.MATCH !== expected_match) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: expected MATCH = %0d, actual MATCH = %0d",
                 expected_match, trans.MATCH))
    end
  endfunction
endclass