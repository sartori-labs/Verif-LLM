// adder_8bit_scoreboard.sv
class adder_8bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_8bit_scoreboard)

  uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) analysis_imp;

  bit [7:0] expected_sum;
  bit expected_cout;

  function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  function void write(adder_8bit_trans trans);
    expected_sum = trans.a + trans.b + trans.cin;
    expected_cout = (trans.a[7] & trans.b[7]) | (trans.a[7] & trans.cin) | (trans.b[7] & trans.cin);
    if (trans.sum !== expected_sum || trans.cout !== expected_cout)
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: expected sum=%h, cout=%h, actual sum=%h, cout=%h", expected_sum, expected_cout, trans.sum, trans.cout))
  endfunction
endclass