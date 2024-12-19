// Scoreboard class
class adder_16bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_16bit_scoreboard)

  uvm_analysis_imp#(adder_16bit_trans, adder_16bit_scoreboard) analysis_imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(adder_16bit_trans trans);
    adder_16bit_trans expected_trans;
    expected_trans = trans;
    expected_trans.y = expected_trans.a + expected_trans.b + expected_trans.Cin;
    if (expected_trans.y > 16'hFFFF) begin
      expected_trans.Co = 1;
      expected_trans.y = expected_trans.y & 16'hFFFF;
    end else begin
      expected_trans.Co = 0;
    end
    if (trans != expected_trans) begin
      `uvm_error("SB_ERROR", {"Mismatch between actual and expected transaction: ", trans.sprint(), " != ", expected_trans.sprint()})
    end
  endfunction
endclass