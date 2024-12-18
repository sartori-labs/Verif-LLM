// alu_transaction.sv
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

  // Define parameters for opcodes
  localparam ADD = 6'b100000;
  localparam ADDU = 6'b100001;
  localparam SUB = 6'b100010;
  localparam SUBU = 6'b100011;
  localparam AND = 6'b100100;
  localparam OR = 6'b100101;
  localparam XOR = 6'b100110;
  localparam NOR = 6'b100111;
  localparam SLT = 6'b101010;
  localparam SLTU = 6'b101011;
  localparam SLL = 6'b000000;
  localparam SRL = 6'b000010;
  localparam SRA = 6'b000011;
  localparam SLLV = 6'b000100;
  localparam SRLV = 6'b000110;
  localparam SRAV = 6'b000111;
  localparam LUI = 6'b001111;

  function new(string name = "alu_transaction");
    super.new(name);
  endfunction

  // Constraint to randomize aluc using opcode parameters
  constraint aluc_constraint {
    aluc inside {ADD, ADDU, SUB, SUBU, AND, OR, XOR, 
                 NOR, SLT, SLTU, SLL, SRL, SRA, 
                 SLLV, SRLV, SRAV, LUI};
  }
endclass
