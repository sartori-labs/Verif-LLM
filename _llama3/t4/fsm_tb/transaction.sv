
// Transaction class
class fsm_trans extends uvm_sequence_item;
  `uvm_object_utils(fsm_trans)

  rand bit IN;
  rand bit RST;
  bit MATCH;
  bit CLK;

  constraint clk_constraint {CLK == 0; }
  constraint rst_constraint {RST == 0; }

  function new(string name = "fsm_trans");
    super.new(name);
  endfunction

endclass