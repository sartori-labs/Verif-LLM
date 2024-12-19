// Scoreboard class
class adder_8bit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_8bit_scoreboard)

    uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) item_imp;

    bit [7:0] expected_sum;
    bit expected_cout;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_imp = new("item_imp", this);
    endfunction

    function void write(adder_8bit_trans trans);
        expected_sum = trans.a + trans.b + trans.cin;
        expected_cout = (trans.a[7] & trans.b[7]) | (trans.a[7] & trans.cin) | (trans.b[7] & trans.cin);
        if (trans.sum !== expected_sum) begin
            `uvm_error("SCOREBOARD", $sformatf("Sum mismatch: expected %h, actual %h", expected_sum, trans.sum));
        end
        if (trans.cout !== expected_cout) begin
            `uvm_error("SCOREBOARD", $sformatf("Carry-out mismatch: expected %b, actual %b", expected_cout, trans.cout));
        end
    endfunction
endclass