// fsm_scoreboard.sv
class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  uvm_analysis_export #(fsm_transaction) ap;

  // Array to track the sequence of inputs for comparison
  bit [4:0] input_history;
  int input_count;

  function new(string name = "fsm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
    input_count = 0;
    input_history = 5'b00000;
  endfunction

  // Task to handle incoming transactions and perform checks
  virtual task write(fsm_transaction tr);
    // Shift left and add the new input bit
    input_history = {input_history[3:0], tr.IN};
    input_count++;

    // Compute the expected MATCH signal based on the input sequence
    logic expected_MATCH = 0;

    // Check for a match when the sequence is "10011"
    if (input_history == 5'b10011) begin
      expected_MATCH = 1;
    end

    // Print a message for clarity during debugging
    `uvm_info("SCOREBOARD", $sformatf("Transaction IN=%0b, MATCH=%0b, Expected MATCH=%0b", 
                                       tr.IN, tr.MATCH, expected_MATCH), UVM_LOW);

    // Compare the expected result with the actual MATCH value
    if (tr.MATCH !== expected_MATCH) begin
      `uvm_error("MISMATCH", $sformatf("Mismatch detected: IN=%0b, MATCH=%0b, Expected MATCH=%0b",
                                       tr.IN, tr.MATCH, expected_MATCH))
    end
  endtask
endclass
