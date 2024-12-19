// fsm_scoreboard.sv
class fsm_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fsm_scoreboard)

    uvm_analysis_port#(fsm_trans) expected_item_port;
    uvm_analysis_port#(fsm_trans) actual_item_port;

    fsm_trans expected_trans;
    fsm_trans actual_trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        expected_item_port = new("expected_item_port", this);
        actual_item_port = new("actual_item_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            expected_item_port.get(expected_trans);
            actual_item_port.get(actual_trans);

            if (expected_trans.MATCH !== actual_trans.MATCH) begin
                `uvm_error("SCOREBOARD", $sformatf("Expected MATCH=%0d, Actual MATCH=%0d", expected_trans.MATCH, actual_trans.MATCH));
            end
        end
    endtask

endclass