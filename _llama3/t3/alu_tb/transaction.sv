class alu_trans extends uvm_sequence_item;
  `uvm_object_utils(alu_trans)

  rand logic [31:0] a;
  rand logic [31:0] b;
  rand logic [5:0] aluc;
  logic [31:0] r;
  logic zero;
  logic carry;
  logic negative;
  logic overflow;
  logic flag;

  function new(string name = "alu_trans");
    super.new(name);
  endfunction

  constraint valid_aluc {
    aluc inside {
      'h00, 'h01, 'h02, 'h03, 'h04, 'h05, 'h06, 'h07, 'h08, 'h09, 'h0A, 'h0B, 'h0C, 'h0D, 'h0E, 'h0F,
      'h10, 'h11, 'h12, 'h13, 'h14, 'h15, 'h16, 'h17, 'h18, 'h19, 'h1A, 'h1B, 'h1C, 'h1D, 'h1E, 'h1F,
      'h20, 'h21, 'h22, 'h23, 'h24, 'h25, 'h26, 'h27, 'h28, 'h29, 'h2A, 'h2B, 'h2C, 'h2D, 'h2E, 'h2F,
      'h30, 'h31, 'h32, 'h33, 'h34, 'h35, 'h36, 'h37, 'h38, 'h39, 'h3A, 'h3B, 'h3C, 'h3D, 'h3E, 'h3F
    };
  }
endclass