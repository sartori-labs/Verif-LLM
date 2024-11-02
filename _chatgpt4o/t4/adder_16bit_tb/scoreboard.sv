// adder_16bit_scoreboard.sv
class adder_16bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_16bit_scoreboard)

  uvm_analysis_imp #(adder_16bit_txn, adder_16bit_scoreboard) trans;

  function new(string name = "adder_16bit_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    trans = new("trans", this);
  endfunction

  function void write(adder_16bit_txn txn);
    bit [15:0] expected_y;
    bit        expected_Co;

    {expected_Co, expected_y} = txn.a + txn.b + txn.Cin;

    if (expected_y !== txn.y || expected_Co !== txn.Co)
      `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected (y=%0d, Co=%0d), Got (y=%0d, Co=%0d)", 
                                         expected_y, expected_Co, txn.y, txn.Co))
    else
      `uvm_info("SCOREBOARD", "Transaction matched expected output", UVM_LOW)
  endfunction
endclass
