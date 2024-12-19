// Sequence class
class adder_8bit_sequence extends uvm_sequence #(adder_8bit_trans);
  `uvm_object_utils(adder_8bit_sequence)

  function new(string name = "adder_8bit_sequence");
    super.new(name);
  endfunction

  task body();
    adder_8bit_trans trans;
    repeat(10) begin
      trans = adder_8bit_trans::type_id::create("trans");
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
    end
  endtask
endclass