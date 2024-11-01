class fsm_transaction extends uvm_sequence_item;
  `uvm_object_utils(fsm_transaction)

  rand bit IN;       // Input signal
  bit MATCH;         // Output signal (observed from DUT)

  function new(string name = "fsm_transaction");
    super.new(name);
  endfunction

  virtual function string convert2string();
    return $sformatf("IN: %0b, MATCH: %0b", IN, MATCH);
  endfunction
endclass
