// transaction.sv
class alu_trans extends uvm_sequence_item;
  rand bit [31:0] a;
  rand bit [31:0] b;
  rand bit [5:0] aluc;

  parameter ADD     = 6'b100000;
  parameter ADDU    = 6'b100001;
  parameter SUB     = 6'b100010;
  parameter SUBU    = 6'b100011;
  parameter AND     = 6'b100100;
  parameter OR      = 6'b100101;
  parameter XOR     = 6'b100110;
  parameter NOR     = 6'b100111;
  parameter SLT     = 6'b101010;
  parameter SLTU    = 6'b101011;
  parameter SLL     = 6'b000000;
  parameter SRL     = 6'b000010;
  parameter SRA     = 6'b000011;
  parameter SLLV    = 6'b000100;
  parameter SRLV    = 6'b000110;
  parameter SRAV    = 6'b000111;
  parameter LUI     = 6'b001111;

  bit [31:0] r;
  bit zero;
  bit carry;
  bit negative;
  bit overflow;
  bit flag;

  constraint aluc_c {
    aluc inside {
      ADD,
      ADDU,
      SUB,
      SUBU,
      AND,
      OR,
      XOR,
      NOR,
      SLT,
      SLTU,
      SLL,
      SRL,
      SRA,
      SLLV,
      SRLV,
      SRAV,
      LUI
    };
  }

  `uvm_object_utils_begin(alu_trans)
  `uvm_field_int(a, UVM_ALL_ON)
  `uvm_field_int(b, UVM_ALL_ON)
  `uvm_field_int(aluc, UVM_ALL_ON)
  `uvm_field_int(r, UVM_ALL_ON)
  `uvm_field_int(zero, UVM_ALL_ON)
  `uvm_field_int(carry, UVM_ALL_ON)
  `uvm_field_int(negative, UVM_ALL_ON)
  `uvm_field_int(overflow, UVM_ALL_ON)
  `uvm_field_int(flag, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "alu_trans");
    super.new(name);
  endfunction
endclass