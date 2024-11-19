// accu_scoreboard.sv
class accu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(accu_scoreboard)

  uvm_analysis_imp #(accu_transaction, accu_scoreboard) analysis_imp;

  logic [9:0] expected_data_out;
  logic [7:0] data_array [0:3];
  int data_count;

  function new(string name = "accu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    data_count = 0;
  endfunction

  function void write(accu_transaction trans);
    if (trans.valid_in) begin
      data_array[data_count] = trans.data_in;
      data_count++;
      if (data_count == 4) begin
        expected_data_out = data_array[0] + data_array[1] + data_array[2] + data_array[3];
        data_count = 0;
        if (trans.valid_out !== 1'b1 || trans.data_out !== expected_data_out) begin
          `uvm_error("ACC_SCOREBOARD", $sformatf("Mismatch: Expected data_out = %h, Received data_out = %h", expected_data_out, trans.data_out))
        end
      end
    end
  endfunction
endclass