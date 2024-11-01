class scoreboard_fsm extends uvm_scoreboard;
  `uvm_component_utils(scoreboard_fsm)

  uvm_analysis_imp #(trans_fsm, scoreboard_fsm) ap;

  function new(string name = "scoreboard_fsm", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual task write(trans_fsm tr);
    bit expected_MATCH;

    // Compute expected result
    static bit [4:0] shift_reg;
    shift_reg = {shift_reg[3:0], tr.IN};

    if (shift_reg == 5'b10011)
      expected_MATCH = 1;
    else
      expected_MATCH = 0;

    if (tr.MATCH !== expected_MATCH) begin
      `uvm_error("MISMATCH", $sformatf("MATCH mismatch: Got %0b, expected %0b", tr.MATCH, expected_MATCH))
    end
  endtask
endclass
