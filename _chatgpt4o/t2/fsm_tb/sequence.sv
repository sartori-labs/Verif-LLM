class seq_fsm extends uvm_sequence #(trans_fsm);
  `uvm_object_utils(seq_fsm)

  function new(string name = "seq_fsm");
    super.new(name);
  endfunction

  virtual task body();
    trans_fsm tr;
    repeat (100) begin // Adjust the number for functional coverage
      tr = trans_fsm::type_id::create("tr");
      `uvm_do(tr)
    end
  endtask
endclass
