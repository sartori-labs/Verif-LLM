// adder_8bit_scoreboard.sv
class adder_8bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_8bit_scoreboard)

  uvm_analysis_imp #(adder_8bit_transaction, adder_8bit_scoreboard) analysis_imp;

  function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  function void write(adder_8bit_transaction trans);
    logic [8:0] expected_sum;
    logic expected_cout;

    expected_sum = trans.a + trans.b + trans.cin;
    expected_cout = expected_sum[8];

    if (trans.sum != expected_sum[7:0] || trans.cout != expected_cout) begin
      `uvm_error("ADDER_SCOREBOARD", $sformatf("Mismatch: a=0x%h, b=0x%h, cin=%b, expected sum=0x%h, cout=%b, actual sum=0x%h, cout=%b",
                                               trans.a, trans.b, trans.cin, expected_sum[7:0], expected_cout, trans.sum, trans.cout))
    end else begin
      `uvm_info("ADDER_SCOREBOARD", $sformatf("Match: a=0x%h, b=0x%h, cin=%b, sum=0x%h, cout=%b",
                                             trans.a, trans.b, trans.cin, trans.sum, trans.cout), UVM_MEDIUM)
    end
  endfunction
endclass