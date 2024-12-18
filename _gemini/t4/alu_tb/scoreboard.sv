// alu_scoreboard.sv
class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) analysis_imp;

  function new(string name = "alu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  // Implement the write method
  function void write(alu_transaction trans);
    check_transaction(trans);
  endfunction

  task run_phase(uvm_phase phase);
    // Add a delay before starting the loop
    #10; 
    forever begin
      alu_transaction trans;
      analysis_imp.get(trans); 
      check_transaction(trans);
    end
  endtask

  function void check_transaction(alu_transaction trans);
    logic [31:0] expected_r;
    logic expected_zero;
    logic expected_carry;
    logic expected_negative;
    logic expected_overflow;
    logic expected_flag;

    case (trans.aluc)
      trans.ADD: begin
        {expected_carry, expected_r} = trans.a + trans.b;
        expected_overflow = (trans.a[31] == trans.b[31]) && (expected_r[31] != trans.a[31]);
      end
      trans.ADDU: begin
        {expected_carry, expected_r} = trans.a + trans.b;
        expected_overflow = 0; 
      end
      trans.SUB: begin
        {expected_carry, expected_r} = trans.a - trans.b;
        expected_overflow = (trans.a[31] != trans.b[31]) && (expected_r[31] != trans.a[31]);
      end
      trans.SUBU: begin
        {expected_carry, expected_r} = trans.a - trans.b;
        expected_overflow = 0; 
      end
      trans.AND:  expected_r = trans.a & trans.b;
      trans.OR:   expected_r = trans.a | trans.b;
      trans.XOR:  expected_r = trans.a ^ trans.b;
      trans.NOR:  expected_r = ~(trans.a | trans.b);
      trans.SLT:  begin
        expected_r = ($signed(trans.a) < $signed(trans.b)) ? 32'd1 : 32'd0;
        expected_flag = ($signed(trans.a) < $signed(trans.b));
      end
      trans.SLTU: begin
        expected_r = (trans.a < trans.b) ? 32'd1 : 32'd0;
        expected_flag = (trans.a < trans.b);
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

    expected_zero = (expected_r == 32'd0);
    expected_negative = expected_r[31];

    if (expected_r !== trans.r) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Result mismatch! a=0x%h, b=0x%h, aluc=0x%h, expected_r=0x%h, r=0x%h", trans.a, trans.b, trans.aluc, expected_r, trans.r))
    end
    if (expected_zero !== trans.zero) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Zero flag mismatch! a=0x%h, b=0x%h, aluc=0x%h, expected_zero=%b, zero=%b", trans.a, trans.b, trans.aluc, expected_zero, trans.zero))
    end
    if (expected_carry !== trans.carry) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Carry flag mismatch! a=0x%h, b=0x%h, aluc=0x%h, expected_carry=%b, carry=%b", trans.a, trans.b, trans.aluc, expected_carry, trans.carry))
    end
    if (expected_negative !== trans.negative) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Negative flag mismatch! a=0x%h, b=0x%h, aluc=0x%h, expected_negative=%b, negative=%b", trans.a, trans.b, trans.aluc, expected_negative, trans.negative))
    end
    if (expected_overflow !== trans.overflow) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Overflow flag mismatch! a=0x%h, b=0x%h, aluc=0x%h, expected_overflow=%b, overflow=%b", trans.a, trans.b, trans.aluc, expected_overflow, trans.overflow))
    end
    if (expected_flag !== trans.flag) begin
      `uvm_error("ALU_SCOREBOARD", $sformatf("Error: Flag mismatch! a=0x%h, b=0x%h, aluc=0x%h, expected_flag=%b, flag=%b", trans.a, trans.b, trans.aluc, expected_flag, trans.flag))
    end
  endfunction
endclass