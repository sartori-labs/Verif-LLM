// Scoreboard Class
class adder_8bit_scoreboard extends uvm_component;
    `uvm_component_utils(adder_8bit_scoreboard)

    uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) analysis_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    virtual function void write(adder_8bit_trans trans);
        bit [8:0] expected_sum;
        expected_sum = trans.a + trans.b + trans.cin;
        if (expected_sum[7:0] !== trans.sum || expected_sum[8] !== trans.cout)
            `uvm_error("MISMATCH", $sformatf("Expected sum=%0h, cout=%0b, Got sum=%0h, cout=%0b", expected_sum[7:0], expected_sum[8], trans.sum, trans.cout))
    endfunction
endclass