// fsm_scoreboard.sv
class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp #(fsm_transaction, fsm_scoreboard) analysis_imp;
  typedef enum { S0, S1, S2, S3, S4 } state_t;
  state_t current_state;

  function new(string name = "fsm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    current_state = S0;
  endfunction

  function void write(fsm_transaction trans);
    bit expected_match;
    case (current_state)
      S0: if (trans.IN) current_state = S1;
      S1: if (!trans.IN) current_state = S2;
      S2: if (!trans.IN) current_state = S3;
      S3: if (trans.IN) current_state = S4;
      S4: begin
        if (trans.IN) begin
          expected_match = 1;
          current_state = S1;
        end else
          current_state = S0;
      end
    endcase

    if (expected_match !== trans.MATCH) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected MATCH = %0d, Actual MATCH = %0d", expected_match, trans.MATCH))
    end
  endfunction
endclass