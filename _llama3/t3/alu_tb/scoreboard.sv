class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp#(alu_trans, alu_scoreboard) item_imp;

  logic [31:0] expected_result;
  logic expected_zero;
  logic expected_carry;
  logic expected_negative;
  logic expected_overflow;
  logic expected_flag;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_imp = new("item_imp", this);
  endfunction

  function void write(alu_trans trans);
    case(trans.aluc)
      'h00: expected_result = trans.a + trans.b;
      'h01: expected_result = trans.a + trans.b;
      'h02: expected_result = trans.a - trans.b;
      'h03: expected_result = trans.a - trans.b;
      'h04: expected_result = trans.a & trans.b;
      'h05: expected_result = trans.a | trans.b;
      'h06: expected_result = trans.a ^ trans.b;
      'h07: expected_result = ~(trans.a | trans.b);
      'h08: expected_result = {trans.a[29:0], 2'b00};
      'h09: expected_result = {trans.a[29:0], 2'b00} >> 2;
      'h0A: expected_result = {trans.a[29:0], 2'b00} >>> 2;
      'h0B: expected_result = trans.a < trans.b;
      'h0C: expected_result = trans.a < trans.b;
      'h0D: expected_result = trans.a << trans.b[4:0];
      'h0E: expected_result = trans.a >> trans.b[4:0];
      'h0F: expected_result = trans.a >>> trans.b[4:0];
      'h10: expected_result = {16'h0000, trans.a[15:0]};
      default: expected_result = 'x;
    endcase
    expected_zero = (expected_result == 0);
    expected_carry = (expected_result[31]);
    expected_negative = (expected_result[31]);
    expected_overflow = (expected_result[31] != trans.a[31] && expected_result[31] != trans.b[31]);
    expected_flag = (trans.aluc == 'h2A || trans.aluc == 'h2B);
    if(trans.r !== expected_result ||
       trans.zero !== expected_zero ||
       trans.carry !== expected_carry ||
       trans.negative !== expected_negative ||
       trans.overflow !== expected_overflow ||
       trans.flag !== expected_flag) begin
      `uvm_error("SCOREBOARD_ERROR", $sformatf("Mismatch between expected and actual results:\nExpected: r=0x%x, zero=%b, carry=%b, negative=%b, overflow=%b, flag=%b\nActual: r=0x%x, zero=%b, carry=%b, negative=%b, overflow=%b, flag=%b",
        expected_result, expected_zero, expected_carry, expected_negative, expected_overflow, expected_flag,
        trans.r, trans.zero, trans.carry, trans.negative, trans.overflow, trans.flag))
    end
  endfunction
endclass