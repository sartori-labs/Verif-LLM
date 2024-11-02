// adder_16bit_seq.sv
class adder_16bit_seq extends uvm_sequence #(adder_16bit_txn);
  `uvm_object_utils(adder_16bit_seq)

  function new(string name = "adder_16bit_seq");
    super.new(name);
  endfunction

  task body();
    adder_16bit_txn txn;
    repeat (100) begin
      txn = adder_16bit_txn::type_id::create("txn");
      start_item(txn);
      assert(txn.randomize());
      finish_item(txn);
    end
  endtask
endclass