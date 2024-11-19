// accu_sequence.sv
class accu_sequence extends uvm_sequence #(accu_transaction);
  `uvm_object_utils(accu_sequence)

  function new(string name = "accu_sequence");
    super.new(name);
  endfunction

  task body();
    accu_transaction trans;

    repeat (10) begin
      trans = accu_transaction::type_id::create("trans");
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask
endclass