module top;

    import alu_pkg::*;

    // Declare clock and reset signals here and initialize them here
    bit clk;
    bit rst;

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        rst = 1;
        #20 rst = 0;
    end

    virtual alu_if vif;
    // Instantiate the Interface and pass it to the design
    alu_if alu_if_inst (.clk(clk), .rst(rst));

    // DUT wrapper instantiation
    alu uut(
        .a(alu_if_inst.a),
        .b(alu_if_inst.b),
        .aluc(alu_if_inst.aluc),
        .r(alu_if_inst.r),
        .zero(alu_if_inst.zero),
        .carry(alu_if_inst.carry),
        .negative(alu_if_inst.negative),
        .overflow(alu_if_inst.overflow),
        .flag(alu_if_inst.flag)
    );
    
    initial begin
        // Set the interface as config object in UVM database
        uvm_config_db #(virtual alu_if)::set(null, "*", "vif", alu_if_inst);
        $dumpfile("dump.vcd"); 
        $dumpvars;    
    end

    initial begin
        run_test("alu_test");
    end
    
endmodule