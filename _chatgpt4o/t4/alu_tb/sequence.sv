// Sequence class
class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence)

  function new(string name = "alu_sequence");
    super.new(name);
  endfunction

  virtual task body();
    alu_transaction tx;
    repeat (100) begin // Loop for high coverage
      tx = alu_transaction::type_id::create("tx");
      start_item(tx);
      if (!tx.randomize()) begin
        `uvm_error("ALU_SEQ", "Failed to randomize transaction")
      end
      finish_item(tx);
    end
  endtask
endclass
