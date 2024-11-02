// Sequence class
class fsm_sequence extends uvm_sequence #(fsm_transaction);
  `uvm_object_utils(fsm_sequence)

  // Constructor
  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  // Task to generate multiple transactions
  virtual task body();
    fsm_transaction tr;
    repeat (100) begin  // Loop to generate high coverage
      tr = fsm_transaction::type_id::create("tr");
      assert(tr.randomize());
      start_item(tr);
      finish_item(tr);
    end
  endtask
endclass