// accu_scoreboard.sv
`ifndef ACCU_SCOREBOARD_SV
`define ACCU_SCOREBOARD_SV

class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_imp#(accu_trans, accu_scoreboard) item_port;

  accu_trans expected_trans;
  int data_out_expected;

  function new(string name = "accu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_port = new("item_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(accu_trans trans);
    data_out_expected = data_out_expected + trans.data_in;
    if (trans.valid_out) begin
      if (trans.data_out != data_out_expected) begin
        `uvm_error("SCOREBOARD", $sformatf("Data mismatch: expected 0x%0h, actual 0x%0h", data_out_expected, trans.data_out))
      end
    end
  endfunction

endclass

`endif
