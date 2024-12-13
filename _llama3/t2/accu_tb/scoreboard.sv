// accu_scoreboard.sv
`ifndef ACCU_SCOREBOARD_SV
`define ACCU_SCOREBOARD_SV

class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_export#(accu_trans) sb_export;
  accu_trans expected_trans;
  bit [9:0] expected_data_out;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_export = new("sb_export", this);
    expected_data_out = 0;
  endfunction

  function void write(accu_trans trans);
    if (trans.valid_out) begin
      if (expected_data_out !== trans.data_out) begin
        `uvm_error("SCOREBOARD", $sformatf("Expected data_out: %h, Actual data_out: %h", expected_data_out, trans.data_out))
      end
      expected_data_out = 0;
    end else begin
      expected_data_out += trans.data_in;
    end
  endfunction

endclass

`endif