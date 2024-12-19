// Scoreboard class
class adder_16bit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_16bit_scoreboard)

    uvm_analysis_imp #(adder_16bit_trans, adder_16bit_scoreboard) item_imp;

    bit [15:0] expected_y;
    bit expected_Co;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_imp = new("item_imp", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void write(adder_16bit_trans trans);
        expected_y = trans.a + trans.b + trans.Cin;
        expected_Co = (trans.a[15] & trans.b[15]) | (trans.a[15] & trans.Cin) | (trans.b[15] & trans.Cin);

        if (trans.y !== expected_y || trans.Co !== expected_Co) begin
            `uvm_error("SCOREBOARD", {"Mismatch detected: ", "Expected y:", expected_y, "Actual y:", trans.y, "Expected Co:", expected_Co, "Actual Co:", trans.Co})
        end
    endfunction
endclass