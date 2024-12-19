// Sequence class
class alu_sequence_item extends uvm_sequence #(alu_trans);
  `uvm_object_utils(alu_sequence_item)

  rand int num_transactions = 10;

  function new(string name = "alu_sequence_item");
    super.new(name);
  endfunction

  task body();
    alu_trans trans;

    repeat (num_transactions) begin
      trans = alu_trans::type_id::create("trans");
      start_item(trans);
      finish_item(trans);
    end
  endtask

endclass
