// Scoreboard class
class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_imp#(accu_trans, accu_scoreboard) item_collected_export;
  accu_trans expected_trans;
  int total_data_in;

  function new(string name = "accu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
    total_data_in = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(accu_trans trans);
    expected_trans = accu_trans::type_id::create("expected_trans");
    expected_trans.data_in = trans.data_in;
    expected_trans.valid_in = trans.valid_in;
    total_data_in += trans.data_in;
    expected_trans.data_out = total_data_in;
    expected_trans.valid_out = (trans.valid_in && (total_data_in % 4 == 0));

    if (trans.data_out !== expected_trans.data_out ||
        trans.valid_out !== expected_trans.valid_out) begin
      `uvm_error("SCOREBOARD_ERROR", $sformatf("Expected data_out: %d, actual data_out: %d, expected valid_out: %b, actual valid_out: %b",
        expected_trans.data_out, trans.data_out, expected_trans.valid_out, trans.valid_out));
    end
  endfunction
endclass