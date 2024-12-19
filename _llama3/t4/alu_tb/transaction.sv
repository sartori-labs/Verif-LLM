// alu_trans.sv
class alu_trans extends uvm_sequence_item;
  `uvm_object_utils(alu_trans)

  // Opcode definitions
  parameter ADD  = 6'b100000;
  parameter ADDU = 6'b100001;
  parameter SUB  = 6'b100010;
  parameter SUBU = 6'b100011;
  parameter AND  = 6'b100100;
  parameter OR   = 6'b100101;
  parameter XOR  = 6'b100110;
  parameter NOR  = 6'b100111;
  parameter SLT  = 6'b101010;
  parameter SLTU = 6'b101011;
  parameter SLL  = 6'b000000;
  parameter SRL  = 6'b000010;
  parameter SRA  = 6'b000011;
  parameter SLLV = 6'b000100;
  parameter SRLV = 6'b000110;
  parameter SRAV = 6'b000111;
  parameter LUI  = 6'b001111;

  rand bit [31:0] a;
  rand bit [31:0] b;
  rand bit [5:0] aluc;

  bit [31:0] r;
  bit zero;
  bit carry;
  bit negative;
  bit overflow;
  bit flag;

  constraint valid_opcode {
    aluc inside {
      ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR,
      SLT, SLTU, SLL, SRL, SRA, SLLV, SRLV, SRAV, LUI
    };
  }

  function new(string name = "alu_trans");
    super.new(name);
  endfunction

  function string convert2string();
    string s;
    case (aluc)
      ADD: s = "ADD";
      ADDU: s = "ADDU";
      SUB: s = "SUB";
      SUBU: s = "SUBU";
      AND: s = "AND";
      OR: s = "OR";
      XOR: s = "XOR";
      NOR: s = "NOR";
      SLT: s = "SLT";
      SLTU: s = "SLTU";
      SLL: s = "SLL";
      SRL: s = "SRL";
      SRA: s = "SRA";
      SLLV: s = "SLLV";
      SRLV: s = "SRLV";
      SRAV: s = "SRAV";
      LUI: s = "LUI";
      default: s = "UNKNOWN";
    endcase
    return $sformatf("Opcode: %s, a: 0x%x, b: 0x%x, r: 0x%x", s, a, b, r);
  endfunction
endclass