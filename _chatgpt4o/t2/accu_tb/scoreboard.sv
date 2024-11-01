class accu_scoreboard extends uvm_component;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_export #(accu_transaction) ap;

  // Internal variables to track accumulation
  bit [9:0] accumulated_sum = 10'd0;
  int data_count = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  task write(accu_transaction trans);
    // Compute expected results and compare
    if (trans.valid_in) begin
      accumulated_sum += trans.data_in; // Add incoming data to the accumulated sum
      data_count++;

      // Check if 4 data inputs have been accumulated
      if (data_count == 4) begin
        // Expected result after 4 inputs
        bit [9:0] expected_data_out = accumulated_sum;

        // Check against the actual data_out from the DUT
        if (vif.data_out !== expected_data_out) begin
          `uvm_error("SCORE", $sformatf("Mismatch: expected %0d, got %0d", expected_data_out, vif.data_out));
        end else begin
          `uvm_info("SCORE", $sformatf("Match: expected %0d, got %0d", expected_data_out, vif.data_out), UVM_LOW);
        end

        // Reset accumulation for the next set of 4 inputs
        accumulated_sum = 10'd0;
        data_count = 0;
      end
    end
  endtask
endclass
