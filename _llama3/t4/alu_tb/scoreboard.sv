// alu_scoreboard.sv
class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp#(alu_trans, alu_scoreboard) item_imp;

  alu_trans expected_trans;
  alu_trans actual_trans;

  function new(string name = "alu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_imp = new("item_imp", this);
  endfunction

  function void write(alu_trans trans);
    actual_trans = trans;
    compare_results();
  endfunction

  function void compare_results();
    // Compute expected results
    case (expected_trans.aluc)
      alu_trans::ADD: expected_trans.r = expected_trans.a + expected_trans.b;
      alu_trans::ADDU: expected_trans.r = expected_trans.a + expected_trans.b;
      alu_trans::SUB: expected_trans.r = expected_trans.a - expected_trans.b;
      alu_trans::SUBU: expected_trans.r = expected_trans.a - expected_trans.b;
      alu_trans::AND: expected_trans.r = expected_trans.a & expected_trans.b;
      alu_trans::OR: expected_trans.r = expected_trans.a | expected_trans.b;
      alu_trans::XOR: expected_trans.r = expected_trans.a ^ expected_trans.b;
      alu_trans::NOR: expected_trans.r = ~(expected_trans.a | expected_trans.b);
      alu_trans::SLT: expected_trans.flag = expected_trans.a < expected_trans.b;
      alu_trans::SLTU: expected_trans.flag = expected_trans.a < expected_trans.b;
      alu_trans::SLL: expected_trans.r = expected_trans.a << expected_trans.b[4:0];
      alu_trans::SRL: expected_trans.r = expected_trans.a >> expected_trans.b[4:0];
      alu_trans::SRA: expected_trans.r = $signed(expected_trans.a) >>> expected_trans.b[4:0];
      alu_trans::SLLV: expected_trans.r = expected_trans.a << expected_trans.b[4:0];
      alu_trans::SRLV: expected_trans.r = expected_trans.a >> expected_trans.b[4:0];
      alu_trans::SRAV: expected_trans.r = $signed(expected_trans.a) >>> expected_trans.b[4:0];
      alu_trans::LUI: expected_trans.r = {expected_trans.b[15:0], 16'h0};
      default: `uvm_fatal("SCOREBOARD", "Unknown opcode")
    endcase

    // Compare actual and expected results
    if (actual_trans.r !== expected_trans.r ||
        actual_trans.zero !== (expected_trans.r == 0) ||
        actual_trans.carry !== (expected_trans.r[31] ^ expected_trans.a[31] ^ expected_trans.b[31]) ||
        actual_trans.negative !== expected_trans.r[31] ||
        actual_trans.overflow !== (expected_trans.r[31] ^ expected_trans.a[31] ^ expected_trans.b[31]) ||
        actual_trans.flag !== expected_trans.flag)
      `uvm_error("SCOREBOARD", "Mismatch between actual and expected results")
  endfunction
endclass