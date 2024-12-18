// alu_sequence.sv
class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence)

  function new(string name = "alu_sequence");
    super.new(name);
  endfunction

  task body();
    alu_transaction trans;

    repeat (100) begin
      trans = alu_transaction::type_id::create("trans");
      trans.randomize();
      `uvm_info("ALU_SEQUENCE", $sformatf("Sending transaction: a=0x%h, b=0x%h, aluc=0x%h", trans.a, trans.b, trans.aluc), UVM_MEDIUM)
      start_item(trans);
      finish_item(trans);
    end
  endtask
endclass
