class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_imp#(fsm_trans, fsm_scoreboard) item_collected_export;
  fsm_trans expected_trans;
  fsm_trans actual_trans;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction

  function void write(fsm_trans trans);
    actual_trans = trans;
    if (actual_trans.MATCH !== expected_trans.MATCH) begin
      `uvm_error("MATCH_MISMATCH", $sformatf("Expected MATCH=%0d, Actual MATCH=%0d", expected_trans.MATCH, actual_trans.MATCH));
    end
  endfunction
endclass