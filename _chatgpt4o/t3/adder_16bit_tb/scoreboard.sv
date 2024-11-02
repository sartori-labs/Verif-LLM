// UVM scoreboard class
class adder_16bit_scoreboard extends uvm_component;
  `uvm_component_utils(adder_16bit_scoreboard)

  uvm_analysis_export #(adder_16bit_trans) analysis_export;

  function new(string name = "adder_16bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  task write(adder_16bit_trans trans);
    bit [16:0] expected_sum;
    expected_sum = {1'b0, trans.a} + {1'b0, trans.b} + trans.Cin;
    if (expected_sum[15:0] !== trans.y || expected_sum[16] !== trans.Co) begin
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected y=%0h, Co=%0b, Got y=%0h, Co=%0b",
                                         expected_sum[15:0], expected_sum[16], trans.y, trans.Co))
    end else begin
      `uvm_info("SCOREBOARD", "Transaction passed", UVM_LOW)
    end
  endtask
endclass