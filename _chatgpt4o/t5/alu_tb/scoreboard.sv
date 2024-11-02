class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) ap;
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual task write(alu_transaction trans);
    // Compute the expected result based on `aluc`
    logic [31:0] expected_r;
    logic expected_zero, expected_carry, expected_negative, expected_overflow, expected_flag;

    // Implement expected output computation based on `trans.aluc`

    // Compare expected vs. actual and report mismatches
    if (trans.r !== expected_r || trans.zero !== expected_zero || trans.carry !== expected_carry ||
        trans.negative !== expected_negative || trans.overflow !== expected_overflow || trans.flag !== expected_flag) begin
      `uvm_error("MISMATCH", $sformatf("Mismatch detected. Expected: %0d, Actual: %0d", expected_r, trans.r))
    end
  endtask
endclass
