// accu_scoreboard.sv
class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_imp #(accu_transaction, accu_scoreboard) analysis_imp;

  logic [9:0] expected_data_out;
  logic expected_valid_out;
  int data_count;
  logic [9:0] accumulated_sum;

  function new(string name = "accu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    data_count = 0;
    accumulated_sum = 0;
  endfunction

  function void write(accu_transaction trans);
    // Accumulate input data
    if (trans.valid_in) begin
      accumulated_sum += trans.data_in;
      data_count++;
    end

    // Check if 4 data points have been accumulated
    if (data_count == 4) begin
      expected_valid_out = 1;
      expected_data_out = accumulated_sum;
      data_count = 0;
      accumulated_sum = 0;
    end else begin
      expected_valid_out = 0;
      expected_data_out = 0; // Or keep previous value if needed
    end

    // Compare with actual output
    if (trans.data_out != expected_data_out) begin
      `uvm_error("accu_scoreboard", $sformatf("Data mismatch: expected %h, got %h", 
                                             expected_data_out, trans.data_out))
    end
    if (trans.valid_out != expected_valid_out) begin
      `uvm_error("accu_scoreboard", $sformatf("Valid mismatch: expected %h, got %h", 
                                             expected_valid_out, trans.valid_out))
    end
  endfunction
endclass