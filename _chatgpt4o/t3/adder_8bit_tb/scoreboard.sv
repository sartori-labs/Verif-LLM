class adder_8bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_8bit_scoreboard)

  uvm_analysis_imp #(adder_8bit_transaction, adder_8bit_scoreboard) sb_port;

  function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    sb_port = new("sb_port", this);
  endfunction

  virtual function void write(adder_8bit_transaction tr);
    bit [7:0] expected_sum;
    bit expected_cout;

    {expected_cout, expected_sum} = tr.a + tr.b + tr.cin;

    if (tr.sum !== expected_sum || tr.cout !== expected_cout) begin
      `uvm_error("MISMATCH", $sformatf("Expected sum=%0h cout=%0b, got sum=%0h cout=%0b",
                                       expected_sum, expected_cout, tr.sum, tr.cout))
    end else begin
      `uvm_info("MATCH", "Transaction matched expected values", UVM_MEDIUM)
    end
  endfunction
endclass
