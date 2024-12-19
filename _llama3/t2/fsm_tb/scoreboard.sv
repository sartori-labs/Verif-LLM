// Scoreboard class
class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  fsm_trans expected_trans;
  fsm_trans actual_trans;

  uvm_analysis_export#(fsm_trans) expected_analysis_export;
  uvm_analysis_export#(fsm_trans) actual_analysis_export;

  function new(string name = "fsm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    expected_analysis_export = new("expected_analysis_export", this);
    actual_analysis_export = new("actual_analysis_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write_expected(fsm_trans trans);
    expected_trans = trans;
  endfunction

  function void write_actual(fsm_trans trans);
    actual_trans = trans;
    check_result();
  endfunction

  function void check_result();
    if (expected_trans.match !== actual_trans.match) begin
      `uvm_error("MATCH_MISMATCH", {"Expected match: ", expected_trans.match, " Actual match: ", actual_trans.match})
    end
  endfunction
endclass