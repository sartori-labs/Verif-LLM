// alu_scoreboard.sv
class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) analysis_imp;

  function new(string name = "alu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      alu_transaction trans;
      analysis_imp.get(trans); // Use get() instead of get_next_item()
      check_transaction(trans);
    end
  endtask

  // Add a write method to the scoreboard
  function void write(alu_transaction trans);
    analysis_imp.put(trans); 
  endfunction

  function void check_transaction(alu_transaction trans);
    logic [31:0] expected_r;
    logic expected_zero, expected_carry, expected_negative, expected_overflow, expected_flag;

    case (trans.aluc)
      trans.ADD: begin
        {expected_carry, expected_r} = trans.a + trans.b;
        expected_overflow = (trans.a[31] == trans.b[31]) && (expected_r[31] != trans.a[31]);
      end
      trans.ADDU: begin
        expected_r = trans.a + trans.b;
      end
      trans.SUB: begin
        {expected_carry, expected_r} = trans.a - trans.b;
        expected_overflow = (trans.a[31] != trans.b[31]) && (expected_r[31] == trans.b[31]);
      end
      trans.SUBU: begin
        expected_r = trans.a - trans.b;
      end
      trans.AND:  expected_r = trans.a & trans.b;
      trans.OR:   expected_r = trans.a | trans.b;
      trans.XOR:  expected_r = trans.a ^ trans.b;
      trans.NOR:  expected_r = ~(trans.a | trans.b);
      trans.SLT: begin
        expected_r = $signed(trans.a) < $signed(trans.b);
        expected_flag = $signed(trans.a) < $signed(trans.b); 
      end
      trans.SLTU: begin
        expected_r = trans.a < trans.b;
        expected_flag = trans.a < trans.b;
      end
      trans.SLL:  expected_r = trans.b << trans.a[4:0];
      trans.SRL:  expected_r = trans.b >> trans.a[4:0];
      trans.SRA:  expected_r = $signed(trans.b) >>> trans.a[4:0];
      trans.SLLV: expected_r = trans.b << trans.a[4:0];
      trans.SRLV: expected_r = trans.b >> trans.a[4:0];
      trans.SRAV: expected_r = $signed(trans.b) >>> trans.a[4:0];
      trans.LUI:  expected_r = trans.b << 16; 
      default: expected_r = 32'bx; 
    endcase

    expected_zero = (expected_r == 32'b0);
    expected_negative = expected_r[31];

    if (trans.r !== expected_r) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Result mismatch! a: 0x%h, b: 0x%h, aluc: 0x%h, Expected r: 0x%h, Actual r: 0x%h", 
                                            trans.a, trans.b, trans.aluc, expected_r, trans.r))
    end

    // Checks for zero, carry, negative, overflow, and flag
    if (trans.zero !== expected_zero) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Zero flag mismatch! Expected: %b, Actual: %b", expected_zero, trans.zero));
    end

    if (trans.carry !== expected_carry) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Carry flag mismatch! Expected: %b, Actual: %b", expected_carry, trans.carry));
    end

    if (trans.negative !== expected_negative) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Negative flag mismatch! Expected: %b, Actual: %b", expected_negative, trans.negative));
    end

    if (trans.overflow !== expected_overflow) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Overflow flag mismatch! Expected: %b, Actual: %b", expected_overflow, trans.overflow));
    end

    if ((trans.aluc == trans.SLT || trans.aluc == trans.SLTU) && (trans.flag !== expected_flag)) begin 
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Flag mismatch for SLT/SLTU! Expected: %b, Actual: %b", expected_flag, trans.flag));
    end
  endfunction
endclass