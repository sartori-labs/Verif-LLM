// Sequence class: Generates multiple transactions
class fsm_sequence extends uvm_sequence #(fsm_transaction);
  `uvm_object_utils(fsm_sequence)

  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  virtual task body();
    fsm_transaction tx;

    for (int i = 0; i < 100; i++) begin // Generate 100 transactions for coverage
      tx = fsm_transaction::type_id::create("tx");
      start_item(tx);
      assert(tx.randomize());
      finish_item(tx);
    end
  endtask
endclass