// accu_sequence.sv
`ifndef ACCU_SEQUENCE_SV
`define ACCU_SEQUENCE_SV

class accu_sequence extends uvm_sequence#(accu_trans);
  `uvm_object_utils(accu_sequence)

  rand int num_transactions = 10;

  function new(string name = "accu_sequence");
    super.new(name);
  endfunction

  task body();
    accu_trans trans;
    repeat (num_transactions) begin
      `uvm_do(trans)
    end
  endtask

endclass

`endif
