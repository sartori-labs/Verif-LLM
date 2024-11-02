// fsm_sequence.sv
class fsm_sequence extends uvm_sequence #(fsm_transaction);
  `uvm_object_utils(fsm_sequence)

  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  virtual task body();
    fsm_transaction tr;
    repeat (100) begin  // Generate 100 transactions for high functional coverage
      tr = fsm_transaction::type_id::create("tr");
      start_item(tr);
      assert (tr.randomize());
      finish_item(tr);
    end
  endtask
endclass
