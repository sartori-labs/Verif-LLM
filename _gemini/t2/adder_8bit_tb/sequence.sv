// adder_8bit_sequence.sv
class adder_8bit_sequence extends uvm_sequence #(adder_8bit_transaction);
  `uvm_object_utils(adder_8bit_sequence)

  function new(string name = "adder_8bit_sequence");
    super.new(name);
  endfunction

  task body();
    adder_8bit_transaction trans;

    repeat (100) begin
      trans = adder_8bit_transaction::type_id::create("trans");
      trans.randomize();
      `uvm_info("ADDER_SEQ", $sformatf("Sending transaction: a=0x%h, b=0x%h, cin=%b", trans.a, trans.b, trans.cin), UVM_MEDIUM)
      start_item(trans);
      finish_item(trans);
    end
  endtask
endclass