// alu_sequence.sv
class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence)

  function new(string name = "alu_sequence");
    super.new(name);
  endfunction

  task body();
    alu_transaction trans;

    repeat (100) begin
      trans = alu_transaction::type_id::create("trans");
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask
endclass