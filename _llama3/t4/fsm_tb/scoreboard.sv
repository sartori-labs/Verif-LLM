class fsm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fsm_scoreboard)

  fsm_trans act_trans;
  uvm_analysis_export#(fsm_trans) act_port;
  int match_count;
  bit expected_match;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    act_port = new("act_port", this);
    match_count = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  function void write_act(fsm_trans trans);
    act_trans = trans;
    expected_match = check_match(act_trans.IN);
    if (act_trans.MATCH == expected_match) begin
      `uvm_info("MATCH", $sformatf("Expected MATCH=%0b Actual MATCH=%0b", expected_match, act_trans.MATCH), UVM_LOW)
      match_count++;
    end else begin
      `uvm_error("MISMATCH", $sformatf("Expected MATCH=%0b Actual MATCH=%0b", expected_match, act_trans.MATCH))
    end
  endfunction

function bit check_match(bit IN);
  // Implement the logic to check if the MATCH signal should be high based on the IN signal sequence
  // For example, let's assume the MATCH signal should be high when the IN signal sequence is 1, 0, 0, 1, 1
  static bit in_sequence[5];
  static int sequence_index = 0;
  in_sequence[sequence_index++] = IN;
  if (sequence_index == 5) begin
    sequence_index = 0;
    if (in_sequence[0] == 1 && 
        in_sequence[1] == 0 && 
        in_sequence[2] == 0 && 
        in_sequence[3] == 1 && 
        in_sequence[4] == 1) return 1;
  end
  return 0;
endfunction

endclass