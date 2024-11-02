// Scoreboard class
class alu_scoreboard extends uvm_component;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) sb_ap;
  bit [31:0] expected_r;
  bit expected_zero, expected_carry, expected_negative, expected_overflow, expected_flag;

  function new(string name = "alu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    sb_ap = new("sb_ap", this);
  endfunction

  virtual task write(alu_transaction tr);
    // Compute expected results based on the operation and verify
    // (Logic for expected computation omitted for brevity; include actual ALU logic)
    
    if (tr.r !== expected_r || tr.zero !== expected_zero || 
        tr.carry !== expected_carry || tr.negative !== expected_negative || 
        tr.overflow !== expected_overflow || tr.flag !== expected_flag) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch detected: Got r=%0h, Expected r=%0h", tr.r, expected_r))
    end
  endtask
endclass