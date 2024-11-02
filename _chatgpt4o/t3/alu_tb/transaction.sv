// alu_transaction.sv - Transaction Class
class alu_transaction extends uvm_sequence_item;
  `uvm_object_utils(alu_transaction)

  rand logic [31:0] a;
  rand logic [31:0] b;
  rand logic [5:0] aluc;
  logic [31:0] r;
  logic zero;
  logic carry;
  logic negative;
  logic overflow;
  logic flag;

  function new(string name = "alu_transaction");
    super.new(name);
  endfunction
endclass