class trans_fsm extends uvm_sequence_item;
  rand bit IN;
  bit MATCH; // Output is sampled, not randomized

  `uvm_object_utils_begin(trans_fsm)
    `uvm_field_int(IN, UVM_ALL_ON)
    `uvm_field_int(MATCH, UVM_DEFAULT) // No need for UVM_NO_CMP
  `uvm_object_utils_end

  function new(string name = "trans_fsm");
    super.new(name);
  endfunction
endclass
