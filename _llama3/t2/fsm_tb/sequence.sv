// Sequence class
class fsm_sequence extends uvm_sequence#(fsm_trans);
  `uvm_object_utils(fsm_sequence)

  fsm_trans trans;

  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  task body();
    repeat(100) begin
      `uvm_do(trans)
    end
  endtask
endclass
