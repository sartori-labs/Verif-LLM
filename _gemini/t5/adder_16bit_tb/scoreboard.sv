// adder_16bit_scoreboard.sv
class adder_16bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_16bit_scoreboard)

  uvm_analysis_imp #(adder_16bit_transaction, adder_16bit_scoreboard) analysis_imp;

  function new(string name = "adder_16bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  function void write(adder_16bit_transaction trans);
    logic [16:0] expected_sum;
    logic expected_Co;

    expected_sum = trans.a + trans.b + trans.Cin;
    expected_Co = expected_sum[16];

    if (trans.y !== expected_sum[15:0] || trans.Co !== expected_Co) begin
      `uvm_error("ADDER_SCOREBOARD", $sformatf("Mismatch! a=0x%h b=0x%h Cin=%b Expected: y=0x%h Co=%b Actual: y=0x%h Co=%b", 
                                               trans.a, trans.b, trans.Cin, expected_sum[15:0], expected_Co, trans.y, trans.Co))
    end else begin
      `uvm_info("ADDER_SCOREBOARD", $sformatf("Match! a=0x%h b=0x%h Cin=%b y=0x%h Co=%b", 
                                             trans.a, trans.b, trans.Cin, trans.y, trans.Co), UVM_MEDIUM)
    end
  endfunction
endclass