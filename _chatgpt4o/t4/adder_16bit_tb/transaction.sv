// adder_16bit_txn.sv
class adder_16bit_txn extends uvm_sequence_item;
  `uvm_object_utils(adder_16bit_txn)

  rand bit [15:0] a;
  rand bit [15:0] b;
  rand bit        Cin;
  bit [15:0]      y;
  bit             Co;

  function new(string name = "adder_16bit_txn");
    super.new(name);
  endfunction

  // Optionally, if you need packing functionality, you can override do_pack:
  // function void do_pack(output uvm_packer packer);
  //   super.do_pack(packer);
  //   packer.pack_field_int(a, 16);
  //   packer.pack_field_int(b, 16);
  //   packer.pack_field_int(Cin, 1);
  // endfunction
endclass
