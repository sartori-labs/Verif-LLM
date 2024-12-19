// Transaction class
class fsm_trans extends uvm_sequence_item;
  `uvm_object_utils(fsm_trans)

  rand bit in;
  rand bit rst_n;
  bit match;

  constraint in_c { in dist {0:/50, 1:/50}; }
  constraint rst_n_c { rst_n dist {0:/30, 1:/70}; }

  function new(string name = "fsm_trans");
    super.new(name);
  endfunction

endclass