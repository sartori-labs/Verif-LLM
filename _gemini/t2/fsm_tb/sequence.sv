class fsm_sequence extends uvm_sequence #(transaction);
  `uvm_object_utils(fsm_sequence)

  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  task body();
    transaction trans;
    repeat (100) begin
      trans = transaction::type_id::create("trans");
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask
endclass