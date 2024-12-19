// Scoreboard class
class adder_8bit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_8bit_scoreboard)

    uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) item_collected_export;

    bit [7:0] expected_sum;
    bit expected_cout;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_collected_export = new("item_collected_export", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void write(adder_8bit_trans trans);
        expected_sum = trans.a + trans.b + trans.cin;
        expected_cout = (trans.a[7] & trans.b[7]) | (trans.a[7] & trans.cin) | (trans.b[7] & trans.cin);
        if (trans.sum !== expected_sum || trans.cout !== expected_cout)
            `uvm_error("SCOREBOARD", $sformatf("Mismatch: expected sum=%b, cout=%b, actual sum=%b, cout=%b", expected_sum, expected_cout, trans.sum, trans.cout))
    endfunction
endclass