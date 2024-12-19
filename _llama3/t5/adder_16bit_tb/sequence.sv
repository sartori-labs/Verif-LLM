// Sequence class
class adder_16bit_sequence extends uvm_sequence#(adder_16bit_trans);
  `uvm_object_utils(adder_16bit_sequence)

  function new(string name = "adder_16bit_sequence");
    super.new(name);
  endfunction

  task body();
    adder_16bit_trans trans;
    repeat(100) begin
      trans = adder_16bit_trans::type_id::create("trans");
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask
endclass