class adder_8bit_scoreboard extends uvm_scoreboard;

    uvm_analysis_imp#(adder_8bit_trans, adder_8bit_scoreboard) analysis_export;

    `uvm_component_utils(adder_8bit_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction

    virtual function void write(adder_8bit_trans trans);
        bit [7:0] expected_sum;
        bit expected_cout;

        {expected_cout, expected_sum} = trans.a + trans.b + trans.cin;

        if (expected_sum !== trans.sum || expected_cout !== trans.cout) begin
            `uvm_error("SCOREBOARD", $sformatf("Mismatch: a=%0d b=%0d cin=%0d -> sum=%0d cout=%0d, expected sum=%0d cout=%0d", 
                        trans.a, trans.b, trans.cin, trans.sum, trans.cout, expected_sum, expected_cout))
        end else begin
            `uvm_info("SCOREBOARD", "Transaction PASSED", UVM_MEDIUM)
        end
    endfunction

endclass
