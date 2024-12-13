// accu_scoreboard.sv
`ifndef ACCU_SCOREBOARD_SV
`define ACCU_SCOREBOARD_SV

class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_imp#(accu_trans, accu_scoreboard) item_collected_export;
  accu_trans expected_trans;
  bit [9:0] expected_data_out;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(accu_trans trans);
    expected_data_out = expected_trans.data_out + trans.data_in;
    if (trans.valid_out) begin
      if (expected_data_out !== trans.data_out) begin
        `uvm_error("SCOREBOARD", {"Expected data_out: ", expected_data_out, ", Actual data_out: ", trans.data_out})
      end
    end
  endfunction

endclass

`endif