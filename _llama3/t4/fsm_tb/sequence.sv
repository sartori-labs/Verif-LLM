// Sequence class
class fsm_sequence extends uvm_sequence#(fsm_trans);
  `uvm_object_utils(fsm_sequence)

  fsm_trans trans;

  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  task body();
    repeat(10) begin
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask

endclass
