class adder_8bit_sequence extends uvm_sequence #(adder_8bit_transaction);
  `uvm_object_utils(adder_8bit_sequence)

  function new(string name = "adder_8bit_sequence");
    super.new(name);
  endfunction

  virtual task body();
    adder_8bit_transaction tr;
    repeat(100) begin
      tr = adder_8bit_transaction::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize()) else `uvm_fatal("SEQ", "Randomization failed!")
      finish_item(tr);
    end
  endtask
endclass
