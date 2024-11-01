// Scoreboard class for 8-bit adder
class adder_8bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_8bit_scoreboard)

  uvm_analysis_imp #(adder_8bit_transaction, adder_8bit_scoreboard) analysis_imp;

  function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  virtual task write(adder_8bit_transaction trans);
    bit [7:0] expected_sum;
    bit expected_cout;

    {expected_cout, expected_sum} = trans.a + trans.b + trans.cin;

    if (trans.sum !== expected_sum || trans.cout !== expected_cout) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected sum=%0d, cout=%0d; Got sum=%0d, cout=%0d", 
                                         expected_sum, expected_cout, trans.sum, trans.cout))
    end else begin
      `uvm_info("SCOREBOARD", "Match found", UVM_LOW)
    end
  endtask
endclass
