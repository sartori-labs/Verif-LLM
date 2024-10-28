`ifndef ADDER_8BIT_SCOREBOARD_SV
`define ADDER_8BIT_SCOREBOARD_SV

class adder_8bit_scoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) analysis_imp;

    `uvm_component_utils(adder_8bit_scoreboard)

    function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        analysis_imp = new("analysis_imp", this);
    endfunction

    function void write(adder_8bit_trans trans);
        bit [8:0] expected_sum = trans.a + trans.b + trans.cin;
        assert((expected_sum[7:0] == trans.sum) && (expected_sum[8] == trans.cout)) 
            else `uvm_error("SCOREBOARD", "Adder result mismatch!");
    endfunction
endclass

`endif
