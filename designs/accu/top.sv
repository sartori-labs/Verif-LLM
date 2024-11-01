module top;

    import accu_pkg::*;

    // Declare clock and reset signals here and initialize them here
    bit clk;
    bit rst_n;

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        rst_n = 0;
        #20 rst_n = 1;
    end

    virtual accu_if vif;
    // Instantiate the Interface and pass it to the design
    accu_if accu_if_inst (.clk(clk), .rst_n(rst_n));

    // DUT wrapper instantiation
    accu uut(
        .clk(accu_if_inst.clk),
        .rst_n(accu_if_inst.rst_n),
        .data_in(accu_if_inst.data_in),
        .valid_in(accu_if_inst.valid_in),
        .valid_out(accu_if_inst.valid_out),
        .data_out(accu_if_inst.data_out)
    );
    
    initial begin
        // Set the interface as config object in UVM database
        uvm_config_db #(virtual accu_if)::set(null, "*", "vif", accu_if_inst);
        $dumpfile("dump.vcd"); 
        $dumpvars;    
    end

    initial begin
        run_test("accu_test");
    end
    
endmodule