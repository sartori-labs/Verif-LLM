// accu_sequence.sv
`ifndef ACCU_SEQUENCE_SV
`define ACCU_SEQUENCE_SV

class accu_sequence extends uvm_sequence#(accu_trans);
  `uvm_object_utils(accu_sequence)

  rand int num_transactions;

  function new(string name = "accu_sequence");
    super.new(name);
  endfunction

  task body();
    for (int i = 0; i < num_transactions; i++) begin
      req = accu_trans::type_id::create("req");
      start_item(req);
      req.randomize();
      finish_item(req);
    end
  endtask

endclass

`endif