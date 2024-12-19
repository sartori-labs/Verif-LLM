class fsm_sequence extends uvm_sequence#(fsm_trans);
  `uvm_object_utils(fsm_sequence)

  rand int num_transactions = 10;

  function new(string name = "fsm_sequence");
    super.new(name);
  endfunction

  task body();
    for (int i = 0; i < num_transactions; i++) begin
      fsm_trans trans;
      trans = fsm_trans::type_id::create("trans");
      start_item(trans);
      trans.randomize();
      finish_item(trans);
    end
  endtask
endclass