// Scoreboard class
class adder_8bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_8bit_scoreboard)

  uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) item_collected_export;
  adder_8bit_trans expected_result;
  adder_8bit_trans actual_result;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(adder_8bit_trans trans);
    actual_result = trans;
    expected_result.a = trans.a;
    expected_result.b = trans.b;
    expected_result.cin = trans.cin;
    expected_result.sum = expected_result.a + expected_result.b + expected_result.cin;
    expected_result.cout = (expected_result.a[7] & expected_result.b[7]) | 
                              (expected_result.a[7] & expected_result.cin) | 
                              (expected_result.b[7] & expected_result.cin);
    if (actual_result.sum !== expected_result.sum || 
        actual_result.cout !== expected_result.cout) begin
      `uvm_error("SCOREBOARD_ERROR", $sformatf("Expected result: sum = %0d, cout = %0d, Actual result: sum = %0d, cout = %0d",
        expected_result.sum, expected_result.cout, actual_result.sum, actual_result.cout));
    end
  endfunction
endclass