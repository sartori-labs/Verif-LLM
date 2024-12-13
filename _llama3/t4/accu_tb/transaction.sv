// accu_trans.sv
`ifndef ACCU_TRANS_SV
`define ACCU_TRANS_SV

class accu_trans extends uvm_sequence_item;
  `uvm_object_utils_begin(accu_trans)
  `uvm_field_int(data_in, UVM_DEFAULT)
  `uvm_field_int(valid_in, UVM_DEFAULT)
  `uvm_field_int(data_out, UVM_DEFAULT)
  `uvm_field_int(valid_out, UVM_DEFAULT)
  `uvm_object_utils_end

  rand bit [7:0] data_in;
  rand bit valid_in;
  bit [9:0] data_out;
  bit valid_out;

  constraint c_data_in { data_in inside {[0:255]}; }
  constraint c_valid_in { valid_in == 1; }

  function new(string name = "accu_trans");
    super.new(name);
  endfunction

endclass

`endif
