// UVM Scoreboard Class
class accu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(accu_scoreboard)

    uvm_analysis_imp #(accu_transaction, accu_scoreboard) analysis_imp;

    function new(string name = "accu_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        analysis_imp = new("analysis_imp", this);
    endfunction

    virtual function void write(accu_transaction trans);
        static int expected_sum = 0;
        if (trans.valid_out) begin
            expected_sum += trans.data_in;
            if (trans.data_out !== expected_sum) begin
                `uvm_error("SCOREBOARD", $sformatf("Mismatch: Expected %0d, got %0d", expected_sum, trans.data_out))
            end
            else begin
                `uvm_info("SCOREBOARD", $sformatf("Match: Got %0d", trans.data_out), UVM_LOW)
            end
            expected_sum = 0; // Reset after each valid_out
        end
        else begin
            expected_sum += trans.data_in;
        end
    endfunction
endclass