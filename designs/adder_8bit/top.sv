`include "uvm_macros.svh"
import uvm_pkg::*;

`ifdef VERIFIED
`include "./testbench/adder_8bit_pkg.sv"
`endif

`ifdef p7
`include "./testbench/p7/adder_8bit_pkg.sv"
`endif


module top;

    import adder_8bit_pkg::*;

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

    virtual adder_8bit_if vif;
    // Instantiate the Interface and pass it to the design
    adder_8bit_if adder_8bit_if_inst (.clk(clk), .rst(rst));

    // DUT wrapper instantiation
    adder_8bit uut(
        .a(adder_8bit_if_inst.a),
        .b(adder_8bit_if_inst.b),
        .cin(adder_8bit_if_inst.cin),
        .sum(adder_8bit_if_inst.sum),
        .cout(adder_8bit_if_inst.cout)
    );
    
    initial begin
        // Set the interface as config object in UVM database
        uvm_config_db #(virtual adder_8bit_if)::set(null, "*", "vif", adder_8bit_if_inst);
        $dumpfile("dump.vcd"); 
        $dumpvars;    
    end

    initial begin
        run_test("adder_8bit_test");
    end
    
endmodule
