class adder_8bit_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_8bit_scoreboard)

    uvm_analysis_imp #(adder_8bit_transaction, adder_8bit_scoreboard) imp;
    bit [7:0] expected_sum;
    bit expected_cout;

    function new(string name = "adder_8bit_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        imp = new("imp", this);
    endfunction

    virtual function void write(adder_8bit_transaction trans);
        // Calculate expected result
        {expected_cout, expected_sum} = trans.a + trans.b + trans.cin;

        // Compare actual results with expected values
        if (trans.sum !== expected_sum || trans.cout !== expected_cout) begin
            `uvm_error("MISMATCH", $sformatf("Mismatch: a=%0d, b=%0d, cin=%0d, expected_sum=%0d, actual_sum=%0d, expected_cout=%0d, actual_cout=%0d",
                                             trans.a, trans.b, trans.cin, expected_sum, trans.sum, expected_cout, trans.cout))
        end else begin
            `uvm_info("MATCH", "Transaction passed", UVM_MEDIUM)
        end
    endfunction
endclass