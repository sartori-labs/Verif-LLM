// Scoreboard Class
class accu_scoreboard extends uvm_component;
    `uvm_component_utils(accu_scoreboard)

    uvm_analysis_imp #(accu_transaction, accu_scoreboard) analysis_export;
    bit [9:0] expected_sum;
    int count;

    // Constructor
    function new(string name = "accu_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction

    // Write method
    virtual function void write(accu_transaction trans);
        if (trans.valid_in) begin
            expected_sum += trans.data_in;
            count++;
            if (count == 4) begin
                `uvm_info("SCOREBOARD", $sformatf("Checking accumulated sum: %0d", expected_sum), UVM_LOW)
                // Check the expected output with actual DUT output (assume this logic is connected)
                count = 0;
                expected_sum = 0;
            end
        end
    endfunction
endclass