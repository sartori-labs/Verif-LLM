class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp #(fsm_transaction, fsm_scoreboard) ap;

  // 5-bit shift register for sequence detection
  int seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void write(fsm_transaction tx);
    // Shift the register left and append the current input
    seq = (seq << 1) | tx.IN;
    seq = seq & 5'b11111; // Ensure only the last 5 bits are kept

    // Check if the sequence matches "1, 0, 0, 1, 1"
    int expected_MATCH = (seq == 5'b10011) ? 1 : 0;

    // Compare expected output to DUT output
    if (expected_MATCH !== tx.MATCH) begin
      `uvm_error("FSM_SCOREBOARD", $sformatf("Mismatch detected! Expected MATCH: %0d, DUT MATCH: %0d", expected_MATCH, tx.MATCH))
    end
  endfunction
endclass
