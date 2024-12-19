// Scoreboard class
class adder_16bit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_16bit_scoreboard)

    uvm_analysis_export#(adder_16bit_trans) analysis_export;
    uvm_analysis_imp#(adder_16bit_trans, adder_16bit_scoreboard) analysis_imp;

    function new(string name = "adder_16bit_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysis_export = new("analysis_export", this);
        analysis_imp = new("analysis_imp", this);
    endfunction

    function void write(adder_16bit_trans trans);
        bit [15:0] expected_y;
        bit expected_Co;

        expected_y = trans.a + trans.b + trans.Cin;
        expected_Co = (trans.a[15] & trans.b[15]) | (trans.a[15] & trans.Cin) | (trans.b[15] & trans.Cin);

        if (trans.y !== expected_y || trans.Co !== expected_Co) begin
            `uvm_error("SCOREBOARD", $sformatf("Mismatch: expected y = %0h, Co = %0b, actual y = %0h, Co = %0b", expected_y, expected_Co, trans.y, trans.Co));
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        analysis_export.connect(analysis_imp);
    endfunction

endclass