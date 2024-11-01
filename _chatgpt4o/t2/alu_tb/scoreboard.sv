class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    uvm_analysis_imp #(alu_transaction, alu_scoreboard) analysis_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    task write(alu_transaction trans);
        bit [31:0] expected_r;
        bit expected_zero, expected_carry, expected_negative, expected_overflow, expected_flag;

        // Compute expected values based on `aluc` and inputs `a`, `b`
        case (trans.aluc)
            6'b100000: {expected_carry, expected_r} = trans.a + trans.b;
            6'b100010: {expected_carry, expected_r} = trans.a - trans.b;
            6'b101010: expected_flag = (trans.a < trans.b) ? 1 : 0;
            6'b101011: expected_flag = ($unsigned(trans.a) < $unsigned(trans.b)) ? 1 : 0;
            // Add more cases as needed for all supported opcodes
            default: expected_r = 32'hx;
        endcase

        expected_zero = (expected_r == 0);
        expected_negative = expected_r[31];
        expected_overflow = ((trans.a[31] == trans.b[31]) && (trans.a[31] != expected_r[31]));

        // Comparison logic
        if (trans.r !== expected_r || trans.zero !== expected_zero || trans.carry !== expected_carry || trans.negative !== expected_negative || trans.overflow !== expected_overflow || trans.flag !== expected_flag) begin
            `uvm_error("SCOREBOARD", $sformatf("Mismatch: Got r=%h, zero=%b, carry=%b, negative=%b, overflow=%b, flag=%b", trans.r, trans.zero, trans.carry, trans.negative, trans.overflow, trans.flag))
        end
    endtask
endclass
