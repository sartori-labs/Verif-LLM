// alu_scoreboard.sv - Scoreboard Class
class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  virtual function void write(alu_transaction tx);
    logic [31:0] expected_result;
    logic expected_zero, expected_carry, expected_negative, expected_overflow, expected_flag;

    // Compute expected results based on ALU operations
    case (tx.aluc)
      6'b100000: expected_result = tx.a + tx.b;  // ADD
      6'b100001: expected_result = tx.a + tx.b;  // ADDU (same as ADD for simulation)
      6'b100010: expected_result = tx.a - tx.b;  // SUB
      6'b100011: expected_result = tx.a - tx.b;  // SUBU (same as SUB for simulation)
      6'b100100: expected_result = tx.a & tx.b;  // AND
      6'b100101: expected_result = tx.a | tx.b;  // OR
      6'b100110: expected_result = tx.a ^ tx.b;  // XOR
      6'b100111: expected_result = ~(tx.a | tx.b); // NOR
      6'b101010: expected_result = (tx.a < tx.b) ? 32'd1 : 32'd0; // SLT
      6'b101011: expected_result = ($unsigned(tx.a) < $unsigned(tx.b)) ? 32'd1 : 32'd0; // SLTU
      6'b000000: expected_result = tx.b << tx.a[4:0];  // SLL
      6'b000010: expected_result = tx.b >> tx.a[4:0];  // SRL
      6'b000011: expected_result = $signed(tx.b) >>> tx.a[4:0]; // SRA
      6'b000100: expected_result = tx.b << tx.a[4:0];  // SLLV
      6'b000110: expected_result = tx.b >> tx.a[4:0];  // SRLV
      6'b000111: expected_result = $signed(tx.b) >>> tx.a[4:0]; // SRAV
      6'b001111: expected_result = {tx.b[15:0], 16'b0}; // LUI
      default: expected_result = 32'b0;
    endcase

    expected_zero = (expected_result == 0);
    expected_negative = expected_result[31];
    expected_carry = 1'b0;  // Simplified, may need adjustment
    expected_overflow = 1'b0;  // Simplified, may need adjustment

    if (tx.r !== expected_result || tx.zero !== expected_zero ||
        tx.negative !== expected_negative || tx.carry !== expected_carry ||
        tx.overflow !== expected_overflow) begin
      `uvm_error("MISMATCH", $sformatf("Mismatch: Expected result: %0h, Got: %0h", expected_result, tx.r))
    end
  endfunction
endclass