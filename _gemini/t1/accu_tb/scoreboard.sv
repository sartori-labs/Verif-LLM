class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_imp #(accu_transaction, accu_scoreboard) analysis_imp;

  logic [9:0] expected_data_out;
  int data_count;

  function new(string name = "accu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    data_count = 0;
    expected_data_out = 0;
  endfunction

  function void write(accu_transaction trans);
    if (trans.valid_in) begin
      data_count++;
      expected_data_out += trans.data_in;
    end

    if (trans.valid_out) begin
      if (trans.data_out != expected_data_out) begin
        uvm_error("SCOREBOARD", $sformatf("Data mismatch! Expected: 0x%h, Actual: 0x%h", 
                                         expected_data_out, trans.data_out));
      end else begin
        uvm_info("SCOREBOARD", $sformatf("Data matched: 0x%h", trans.data_out), UVM_MEDIUM);
      end
      data_count = 0;
      expected_data_out = 0;
    end
  endfunction
endclass