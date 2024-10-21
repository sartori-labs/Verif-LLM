class adder_16bit_scoreboard extends uvm_scoreboard;

    // Utility Macro
    `uvm_component_utils(adder_16bit_scoreboard)

    // Declare the components
    uvm_analysis_imp #(adder_16bit_trans, adder_16bit_scoreboard) analysis_export;
    
    // Constructor
    function new(string name = "adder_16bit_scoreboard", uvm_component parent = null);
        super.new(name, parent);

        // Instantiate the analysis port, because it is a class object
        analysis_export = new("analysis_export", this);
    endfunction : new

    virtual function void write(adder_16bit_trans trans);
        bit [16:0] expected_sum = trans.a + trans.b + trans.Cin;
        if (trans.y != expected_sum[15:0] || trans.Co != expected_sum[16])
            `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected sum = %0h, cout = %0b, got sum = %0h, cout = %0b", expected_sum[15:0], expected_sum[16], trans.y, trans.Co))
    endfunction : write

endclass