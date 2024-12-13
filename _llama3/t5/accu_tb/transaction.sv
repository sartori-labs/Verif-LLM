// accu_trans.sv
`ifndef ACCU_TRANS_SV
`define ACCU_TRANS_SV

class accu_trans extends uvm_sequence_item;
  `uvm_object_utils(accu_trans)

  rand bit [7:0] data_in;
  rand bit valid_in;
  bit [9:0] data_out;
  bit valid_out;

  constraint c_valid_in { valid_in == 1; }

  function new(string name = "accu_trans");
    super.new(name);
  endfunction

endclass

`endif