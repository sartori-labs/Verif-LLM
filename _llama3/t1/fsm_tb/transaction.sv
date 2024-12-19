class fsm_trans extends uvm_sequence_item;
  rand bit IN;
  bit MATCH;
  bit CLK;
  bit RST;

  `uvm_object_utils_begin(fsm_trans)
  `uvm_field_int(IN, UVM_ALL_ON)
  `uvm_field_int(MATCH, UVM_ALL_ON)
  `uvm_field_int(CLK, UVM_ALL_ON)
  `uvm_field_int(RST, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "fsm_trans");
    super.new(name);
  endfunction
endclass