class accu_transaction extends uvm_sequence_item;
  rand bit [7:0] data_in;
  rand bit valid_in;
  
  `uvm_object_utils(accu_transaction)

  function new(string name = "accu_transaction");
    super.new(name);
  endfunction

  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("data_in", data_in, $bits(data_in));
    printer.print_field("valid_in", valid_in, $bits(valid_in));
  endfunction
endclass
