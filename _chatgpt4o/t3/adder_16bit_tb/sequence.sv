// UVM sequence class
class adder_16bit_seq extends uvm_sequence #(adder_16bit_trans);
  `uvm_object_utils(adder_16bit_seq)

  function new(string name = "adder_16bit_seq");
    super.new(name);
  endfunction

  task body();
    adder_16bit_trans trans;
    for (int i = 0; i < 100; i++) begin
      trans = adder_16bit_trans::type_id::create("trans");
      assert(trans.randomize());
      start_item(trans);
      finish_item(trans);
    end
  endtask
endclass