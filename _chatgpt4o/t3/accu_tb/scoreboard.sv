// UVM Scoreboard Class
class accu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(accu_scoreboard)

    uvm_analysis_imp #(accu_transaction, accu_scoreboard) ap;

    function new(string name = "accu_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual task write(accu_transaction trans);
        static bit [9:0] expected_sum = 0;
        static int count = 0;

        if (trans.valid_in) begin
            expected_sum += trans.data_in;
            count++;
        end

        if (count == 4) begin
            if (trans.valid_out && trans.data_out !== expected_sum) begin
                `uvm_error("SCOREBOARD", $sformatf("Mismatch! Expected: %0d, Got: %0d", expected_sum, trans.data_out))
            end else if (trans.valid_out) begin
                `uvm_info("SCOREBOARD", "Match found", UVM_LOW)
            end
            expected_sum = 0;
            count = 0;
        end
    endtask
endclass
