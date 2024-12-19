// Scoreboard class
class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_export #(alu_trans) exp;

  alu_trans expected_trans;
  alu_trans actual_trans;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    exp = new("exp", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(alu_trans trans);
    actual_trans = trans;

    // Compute expected result
    case (actual_trans.aluc)
      'h00: expected_trans.r = actual_trans.a << actual_trans.b[4:0];
      'h01: expected_trans.r = actual_trans.a >> actual_trans.b[4:0];
      'h02: expected_trans.r = actual_trans.a >>> actual_trans.b[4:0];
      'h03: expected_trans.r = actual_trans.a & actual_trans.b;
      'h04: expected_trans.r = actual_trans.a | actual_trans.b;
      'h05: expected_trans.r = actual_trans.a ^ actual_trans.b;
      'h06: expected_trans.r = ~(actual_trans.a | actual_trans.b);
      'h07: expected_trans.r = actual_trans.a + actual_trans.b;
      'h08: expected_trans.r = actual_trans.a - actual_trans.b;
      'h09: expected_trans.r = actual_trans.a < actual_trans.b ? 1 : 0;
      'h0A: expected_trans.r = actual_trans.a < actual_trans.b ? 1 : 0;
      'h0B: expected_trans.r = actual_trans.a << actual_trans.b[4:0];
      'h0C: expected_trans.r = actual_trans.a >> actual_trans.b[4:0];
      'h0D: expected_trans.r = actual_trans.a >>> actual_trans.b[4:0];
      'h0E: expected_trans.r = {16'h0, actual_trans.a[15:0]};
      'h0F: expected_trans.r = {actual_trans.a[15:0], 16'h0};
      default: expected_trans.r = 'h0;
    endcase

    // Check result
    if (expected_trans.r !== actual_trans.r) begin
      `uvm_error("SCOREBOARD", $sformatf("Expected 0x%h, got 0x%h", expected_trans.r, actual_trans.r))
    end

    // Check flags
    if (actual_trans.zero !== (expected_trans.r == 0)) begin
      `uvm_error("SCOREBOARD", $sformatf("Expected zero flag to be %b, got %b", (expected_trans.r == 0), actual_trans.zero))
    end

    if (actual_trans.carry !== (expected_trans.r[31] ^ actual_trans.a[31] ^ actual_trans.b[31])) begin
      `uvm_error("SCOREBOARD", $sformatf("Expected carry flag to be %b, got %b", (expected_trans.r[31] ^ actual_trans.a[31] ^ actual_trans.b[31]), actual_trans.carry))
    end

    if (actual_trans.negative !== expected_trans.r[31]) begin
      `uvm_error("SCOREBOARD", $sformatf("Expected negative flag to be %b, got %b", expected_trans.r[31], actual_trans.negative))
    end

    if (actual_trans.overflow !== ((expected_trans.r[31] ^ actual_trans.a[31] ^ actual_trans.b[31]) && (actual_trans.aluc == 'h07 || actual_trans.aluc == 'h08))) begin
      `uvm_error("SCOREBOARD", $sformatf("Expected overflow flag to be %b, got %b", ((expected_trans.r[31] ^ actual_trans.a[31] ^ actual_trans.b[31]) && (actual_trans.aluc == 'h07 || actual_trans.aluc == 'h08)), actual_trans.overflow))
    end

    if (actual_trans.flag !== ((actual_trans.aluc == 'h09) || (actual_trans.aluc == 'h0A))) begin
      `uvm_error("SCOREBOARD", $sformatf("Expected flag to be %b, got %b", ((actual_trans.aluc == 'h09) || (actual_trans.aluc == 'h0A)), actual_trans.flag))
    end
  endfunction

endclass