// adder_16bit_sequence.sv
class adder_16bit_sequence extends uvm_sequence #(adder_16bit_transaction);
  `uvm_object_utils(adder_16bit_sequence)

  function new(string name = "adder_16bit_sequence");
    super.new(name);
  endfunction

  task body();
    adder_16bit_transaction trans;

    repeat (100) begin
      trans = adder_16bit_transaction::type_id::create("trans");
      trans.randomize();
      `uvm_info("ADDER_SEQ", $sformatf("Sending transaction: a=0x%h b=0x%h Cin=%b", trans.a, trans.b, trans.Cin), UVM_MEDIUM)
      start_item(trans);
      finish_item(trans);
    end
  endtask
endclass