// Scoreboard class
class adder_16bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_16bit_scoreboard)

  uvm_analysis_imp #(adder_16bit_trans, adder_16bit_scoreboard) analysis_imp;
  uvm_analysis_imp #(adder_16bit_trans, adder_16bit_scoreboard) analysis_imp_mon;

  bit [15:0] expected_y;
  bit expected_Co;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    analysis_imp_mon = new("analysis_imp_mon", this);
  endfunction

  virtual function void write(adder_16bit_trans trans);
    expected_y = trans.a + trans.b + trans.Cin;
    expected_Co = (trans.a[15] & trans.b[15]) | (trans.a[15] & trans.Cin) | (trans.b[15] & trans.Cin);
    if (trans.y !== expected_y || trans.Co !== expected_Co) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: expected y = %0h, Co = %0h, actual y = %0h, Co = %0h", expected_y, expected_Co, trans.y, trans.Co))
    end else begin
      `uvm_info("SCOREBOARD", $sformatf("Match: expected y = %0h, Co = %0h, actual y = %0h, Co = %0h", expected_y, expected_Co, trans.y, trans.Co), UVM_HIGH)
    end
  endfunction

  virtual function void write_mon(adder_16bit_trans trans);
    analysis_imp_mon.write(trans);
  endfunction

endclass