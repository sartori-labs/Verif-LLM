// Scoreboard class
class adder_16bit_scoreboard extends uvm_component;
    `uvm_component_utils(adder_16bit_scoreboard)

    uvm_analysis_imp #(adder_16bit_transaction, adder_16bit_scoreboard) analysis_imp;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_imp = new("analysis_imp", this);
    endfunction

    // Write function for analysis port
    virtual function void write(adder_16bit_transaction trans);
        bit [15:0] expected_y;
        bit expected_Co;
        {expected_Co, expected_y} = trans.a + trans.b + trans.Cin;

        if ((trans.y !== expected_y) || (trans.Co !== expected_Co)) begin
            `uvm_error("SB", $sformatf("Mismatch: Expected y=%0h, Co=%0b, Got y=%0h, Co=%0b", expected_y, expected_Co, trans.y, trans.Co))
        end else begin
            `uvm_info("SB", "Transaction matched expected results", UVM_LOW)
        end
    endfunction
endclass
