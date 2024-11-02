// adder_scoreboard.sv
class adder_scoreboard extends uvm_component;
  `uvm_component_utils(adder_scoreboard)

  uvm_analysis_imp #(adder_transaction, adder_scoreboard) imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    imp = new("imp", this);
  endfunction

  virtual task write(adder_transaction trans);
    bit [15:0] expected_y;
    bit expected_Co;

    {expected_Co, expected_y} = trans.a + trans.b + trans.Cin;

    if (trans.y !== expected_y || trans.Co !== expected_Co) begin
      `uvm_error("adder_scoreboard", $sformatf("Mismatch: a=%0h, b=%0h, Cin=%0b | Expected y=%0h, Co=%0b, Got y=%0h, Co=%0b",
                    trans.a, trans.b, trans.Cin, expected_y, expected_Co, trans.y, trans.Co))
    end else begin
      `uvm_info("adder_scoreboard", "Transaction matched expected result", UVM_LOW)
    end
  endtask
endclass
