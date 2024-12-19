// Sequence class
class adder_16bit_sequence extends uvm_sequence #(adder_16bit_trans);
  `uvm_object_utils(adder_16bit_sequence)

  function new(string name = "adder_16bit_sequence");
    super.new(name);
  endfunction

  task body();
    repeat (100) begin
      req = adder_16bit_trans::type_id::create("req");
      start_item(req);
      req.randomize();
      finish_item(req);
    end
  endtask
endclass