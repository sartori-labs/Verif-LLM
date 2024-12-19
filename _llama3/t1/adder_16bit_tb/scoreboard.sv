// Scoreboard class
class adder_16bit_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_16bit_scoreboard)

  uvm_analysis_imp #(adder_16bit_trans, adder_16bit_scoreboard) sb_imp;

  bit [15:0] expected_y;
  bit expected_Co;
  bit [15:0] expected_y_queue[$];
  bit expected_Co_queue[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    sb_imp = new("sb_imp", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(adder_16bit_trans trans);
    expected_y = trans.a + trans.b + trans.Cin;
    expected_Co = (expected_y[15] != trans.a[15] + trans.b[15] + trans.Cin);
    
    expected_y_queue.push_back(expected_y);
    expected_Co_queue.push_back(expected_Co);

    if (expected_y_queue.size() > 1) begin
      bit [15:0] expected_y_prev = expected_y_queue.pop_front();
      bit expected_Co_prev = expected_Co_queue.pop_front();

      if (trans.y !== expected_y_prev || trans.Co !== expected_Co_prev) begin
        `uvm_error("SB", $sformatf("Mismatch! Expected y = %h, Co = %b, but got y = %h, Co = %b", expected_y_prev, expected_Co_prev, trans.y, trans.Co))
      end
    end
  endfunction
endclass
