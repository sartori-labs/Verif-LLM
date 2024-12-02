// Transaction class
class accu_trans extends uvm_sequence_item;
  `uvm_object_utils(accu_trans)

  rand bit [7:0] data_in;
  rand bit valid_in;
  bit [9:0] data_out;
  bit valid_out;

  constraint data_in_c { data_in inside {[0:255]}; }
  constraint valid_in_c { valid_in dist {0:=1, 1:=1}; }

  function new(string name = "accu_trans");
    super.new(name);
  endfunction

endclass