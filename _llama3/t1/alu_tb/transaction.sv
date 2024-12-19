// Transaction class
class alu_trans extends uvm_sequence_item;
  `uvm_object_utils(alu_trans)

  rand bit [31:0] a;
  rand bit [31:0] b;
  rand bit [5:0] aluc;

  bit [31:0] r;
  bit zero;
  bit carry;
  bit negative;
  bit overflow;
  bit flag;

  constraint valid_aluc {
    aluc inside {
      'h00, 'h01, 'h02, 'h03, 'h04, 'h05,
      'h06, 'h07, 'h08, 'h09, 'h0A, 'h0B,
      'h0C, 'h0D, 'h0E, 'h0F, 'h10, 'h11,
      'h12, 'h13, 'h14, 'h15
    };
  }

  function new(string name = "alu_trans");
    super.new(name);
  endfunction

endclass