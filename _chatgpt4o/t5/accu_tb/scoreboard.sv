class accu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(accu_scoreboard)

    uvm_analysis_imp #(accu_transaction, accu_scoreboard) analysis_imp;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_imp = new("analysis_imp", this);
    endfunction

    task write(accu_transaction tr);
        static bit [9:0] accumulated_sum = 0;
        static int count = 0;

        if (tr.valid_in) begin
            accumulated_sum += tr.data_in;
            count++;
        end

        if (count == 4) begin
            if (tr.data_out !== accumulated_sum || tr.valid_out !== 1) begin
                `uvm_error("SCOREBOARD", $sformatf("Mismatch detected! Expected: %0d, Got: %0d", accumulated_sum, tr.data_out))
            end else begin
                `uvm_info("SCOREBOARD", "Output matches expected value.", UVM_MEDIUM)
            end
            accumulated_sum = 0;
            count = 0;
        end
    endtask
endclass
