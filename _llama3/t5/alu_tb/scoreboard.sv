// alu_scoreboard.sv
class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    uvm_analysis_imp#(alu_trans, alu_scoreboard) analysis_imp;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_imp = new("analysis_imp", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void write(alu_trans trans);
        // Compute expected result
        bit [31:0] expected_r;
        bit expected_zero;
        bit expected_carry;
        bit expected_negative;
        bit expected_overflow;
        bit expected_flag;

        case (trans.aluc)
            trans.ADD: begin
                expected_r = trans.a + trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = (expected_r[31] != trans.a[31]);
                expected_negative = expected_r[31];
                expected_overflow = (expected_r[31] != trans.a[31] && expected_r[31] != trans.b[31]);
                expected_flag = 0;
            end

            trans.ADDU: begin
                expected_r = trans.a + trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = (expected_r[31] != trans.a[31]);
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.SUB: begin
                expected_r = trans.a - trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = (expected_r[31] != trans.a[31]);
                expected_negative = expected_r[31];
                expected_overflow = (expected_r[31] != trans.a[31] && expected_r[31] != trans.b[31]);
                expected_flag = 0;
            end

            trans.SUBU: begin
                expected_r = trans.a - trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = (expected_r[31] != trans.a[31]);
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.AND: begin
                expected_r = trans.a & trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.OR: begin
                expected_r = trans.a | trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.XOR: begin
                expected_r = trans.a ^ trans.b;
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.NOR: begin
                expected_r = ~(trans.a | trans.b);
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.SLT: begin
                expected_r = (trans.a < trans.b) ? 1 : 0;
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = expected_r;
            end

            trans.SLTU: begin
                expected_r = (trans.a < trans.b) ? 1 : 0;
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = expected_r;
            end

            trans.SLL: begin
                expected_r = trans.a << trans.b[4:0];
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.SRL: begin
                expected_r = trans.a >> trans.b[4:0];
                expected_zero = (expected_r == 0);
                expected_carry = 0;
                expected_negative = expected_r[31];
                expected_overflow = 0;
                expected_flag = 0;
            end

            trans.SRA: begin
        expected_r = trans.a >>> trans.b[4:0];
        expected_zero = (expected_r == 0);
        expected_carry = 0;
        expected_negative = expected_r[31];
        expected_overflow = 0;
        expected_flag = 0;
    end

    trans.SLLV: begin
        expected_r = trans.a << trans.b[4:0];
        expected_zero = (expected_r == 0);
        expected_carry = 0;
        expected_negative = expected_r[31];
        expected_overflow = 0;
        expected_flag = 0;
    end

    trans.SRLV: begin
        expected_r = trans.a >> trans.b[4:0];
        expected_zero = (expected_r == 0);
        expected_carry = 0;
        expected_negative = expected_r[31];
        expected_overflow = 0;
        expected_flag = 0;
    end

    trans.SRAV: begin
        expected_r = trans.a >>> trans.b[4:0];
        expected_zero = (expected_r == 0);
        expected_carry = 0;
        expected_negative = expected_r[31];
        expected_overflow = 0;
        expected_flag = 0;
    end

    trans.LUI: begin
        expected_r = {trans.b, 16'b0};
        expected_zero = (expected_r == 0);
        expected_carry = 0;
        expected_negative = expected_r[31];
        expected_overflow = 0;
        expected_flag = 0;
    end
    endcase

            // Compare actual and expected results
            if (trans.r !== expected_r ||
                trans.zero !== expected_zero ||
                trans.carry !== expected_carry ||
                trans.negative !== expected_negative ||
                trans.overflow !== expected_overflow ||
                trans.flag !== expected_flag) begin
                `uvm_error("SCOREBOARD", {"Mismatch: ", trans.sprint()})
            end
    endfunction
endclass