// adder_16bit_scoreboard.sv
`ifndef ADDER_16BIT_SCOREBOARD_SV
`define ADDER_16BIT_SCOREBOARD_SV

class adder_16bit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_16bit_scoreboard)

    uvm_analysis_imp #(adder_16bit_transaction, adder_16bit_scoreboard) analysis_imp;

    function new(string name = "adder_16bit_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        analysis_imp = new("analysis_imp", this);
    endfunction

    virtual function void write(adder_16bit_transaction trans);
        bit [16:0] expected_sum;
        expected_sum = trans.a + trans.b + trans.Cin;

        if (trans.y !== expected_sum[15:0] || trans.Co !== expected_sum[16])
            `uvm_error("MISMATCH", $sformatf("Expected y=%h, Co=%h, Got y=%h, Co=%h", expected_sum[15:0], expected_sum[16], trans.y, trans.Co))
        else
            `uvm_info("MATCH", "Transaction matched expected values", UVM_MEDIUM)
    endfunction
endclass

`endif // ADDER_16BIT_SCOREBOARD_SV
