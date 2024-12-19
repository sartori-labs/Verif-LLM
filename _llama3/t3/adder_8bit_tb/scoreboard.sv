// Scoreboard class
class adder_8bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_8bit_scoreboard)

  uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) analysis_imp;

  function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(adder_8bit_trans trans);
    bit [7:0] expected_sum;
    bit expected_cout;
    {expected_cout, expected_sum} = trans.a + trans.b + trans.cin;
    if (trans.sum !== expected_sum || trans.cout !== expected_cout)
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: expected sum = %0h, cout = %0b, actual sum = %0h, cout = %0b",
        expected_sum, expected_cout, trans.sum, trans.cout))
  endfunction
endclass