// accu_transaction.sv
class accu_transaction extends uvm_sequence_item;
  `uvm_object_utils(accu_transaction)

  rand logic [7:0] data_in;
  rand logic valid_in;
  logic valid_out;
  logic [9:0] data_out;

//   `uvm_object_new

  // Macros for I/O
  `define DATA_IN(X)  uvm_info("DRIVER", $sformatf("data_in = 0x%h", X), UVM_MEDIUM)
  `define VALID_IN(X) uvm_info("DRIVER", $sformatf("valid_in = %0d", X), UVM_MEDIUM)
  `define VALID_OUT(X) uvm_info("MONITOR", $sformatf("valid_out = %0d", X), UVM_MEDIUM)
  `define DATA_OUT(X) uvm_info("MONITOR", $sformatf("data_out = 0x%h", X), UVM_MEDIUM)
endclass