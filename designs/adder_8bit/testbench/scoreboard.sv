class adder_8bit_scoreboard extends uvm_scoreboard;

    // Utility Macro
    `uvm_component_utils(adder_8bit_scoreboard)

    // Declare the components
    uvm_analysis_imp #(adder_8bit_trans, adder_8bit_scoreboard) analysis_export;
    
    // Constructor
    function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
        super.new(name, parent);

        // Instantiate the analysis port, because it is a class object
        analysis_export = new("analysis_export", this);
    endfunction : new

    virtual function void write(adder_8bit_trans trans);
        bit [8:0] expected_sum = trans.a + trans.b + trans.cin;
        if (trans.sum != expected_sum[7:0] || trans.cout != expected_sum[8])
            `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected sum = %0h, cout = %0b, got sum = %0h, cout = %0b", expected_sum[7:0], expected_sum[8], trans.sum, trans.cout))
    endfunction : write

endclass