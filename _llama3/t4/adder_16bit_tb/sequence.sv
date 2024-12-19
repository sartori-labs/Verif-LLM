// Sequence class
class adder_16bit_sequence extends uvm_sequence #(adder_16bit_trans);
  `uvm_object_utils(adder_16bit_sequence)

  adder_16bit_trans trans;
  int num_transactions = 10;

  function new(string name = "adder_16bit_sequence");
    super.new(name);
  endfunction

  virtual task body();
    for (int i = 0; i < num_transactions; i++) begin
      `uvm_do(trans)
    end
  endtask

endclass
