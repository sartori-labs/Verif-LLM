// Sequence class to generate multiple transactions
class adder_8bit_sequence extends uvm_sequence #(adder_8bit_transaction);
  `uvm_object_utils(adder_8bit_sequence)

  function new(string name = "adder_8bit_sequence");
    super.new(name);
  endfunction

  virtual task body();
    adder_8bit_transaction trans;
    for (int i = 0; i < 100; i++) begin // Generate 100 transactions for coverage
      trans = adder_8bit_transaction::type_id::create("trans");
      `uvm_do_with(trans, {})
    end
  endtask
endclass
