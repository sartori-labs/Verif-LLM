// alu_sequence.sv - Sequence Class
class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence)

  function new(string name = "alu_sequence");
    super.new(name);
  endfunction

  virtual task body();
    alu_transaction tx;
    repeat (100) begin  // Adjust number for higher functional coverage
      tx = alu_transaction::type_id::create("tx");
      if (!tx.randomize())
        `uvm_error("RANDOMIZATION", "Failed to randomize transaction")
      start_item(tx);
      finish_item(tx);
    end
  endtask
endclass