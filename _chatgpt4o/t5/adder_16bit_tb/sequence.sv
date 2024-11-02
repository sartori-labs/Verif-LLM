// adder_sequence.sv
class adder_sequence extends uvm_sequence #(adder_transaction);
  `uvm_object_utils(adder_sequence)

  function new(string name = "adder_sequence");
    super.new(name);
  endfunction

  virtual task body();
    adder_transaction trans;
    repeat (100) begin // Generate 100 transactions for functional coverage
      trans = adder_transaction::type_id::create("trans");
      start_item(trans);
      if (!trans.randomize()) begin
        `uvm_error("adder_sequence", "Randomization failed")
      end
      finish_item(trans);
    end
  endtask
endclass
