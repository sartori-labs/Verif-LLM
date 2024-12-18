// fsm_scoreboard.sv
class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp #(fsm_transaction, fsm_scoreboard) analysis_imp;

  function new(string name = "fsm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  // Function to implement the scoreboard logic
  function void write(fsm_transaction trans);
    if (check_match(trans.IN)) begin
      if (trans.MATCH !== 1'b1)
        `uvm_error("SCOREBOARD", "MATCH mismatch! Expected 1, got 0")
    end else begin
      if (trans.MATCH !== 1'b0)
        `uvm_error("SCOREBOARD", "MATCH mismatch! Expected 0, got 1")
    end
  endfunction

  // Helper function to check for the match condition
  function bit check_match(bit IN);
    static bit [4:0] seq; // Changed 'sequence' to 'seq'
    seq = {seq[3:0], IN};
    if (seq == 5'b10011) 
      return 1'b1;
    else 
      return 1'b0; 
  endfunction 
endclass