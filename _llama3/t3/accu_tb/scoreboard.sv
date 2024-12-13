// Scoreboard class
class accu_scoreboard extends uvm_scoreboard;
    uvm_analysis_port#(accu_trans) item_port;
    accu_trans expected_trans;
    accu_trans actual_trans;

    `uvm_component_utils(accu_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_port = new("item_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void write(accu_trans trans);
        actual_trans = trans;
        if (expected_trans.data_out !== actual_trans.data_out) begin
            `uvm_error("SCOREBOARD", {"Mismatch: expected data_out = ", expected_trans.data_out, ", actual data_out = ", actual_trans.data_out})
        end
        if (expected_trans.valid_out !== actual_trans.valid_out) begin
            `uvm_error("SCOREBOARD", {"Mismatch: expected valid_out = ", expected_trans.valid_out, ", actual valid_out = ", actual_trans.valid_out})
        end
    endfunction
endclass
