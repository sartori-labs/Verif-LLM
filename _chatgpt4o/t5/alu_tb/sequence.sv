class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence)

  function new(string name = "alu_sequence");
    super.new(name);
  endfunction

  virtual task body();
    alu_transaction trans;
    for (int i = 0; i < 100; i++) begin // Loop for high functional coverage
      trans = alu_transaction::type_id::create("trans");
      if (!$random()) `uvm_fatal("SEED_FAIL", "Randomization failed")
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask
endclass
