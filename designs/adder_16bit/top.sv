`include "uvm_macros.svh"
import uvm_pkg::*;

// `ifdef VERIFIED
`include "./testbench/adder_16bit_pkg.sv"
// `endif
module top;

    import adder_16bit_pkg::*;

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

    virtual adder_16bit_if vif;
    // Instantiate the Interface and pass it to the design
    adder_16bit_if adder_16bit_if_inst (.clk(clk), .rst(rst));

    // DUT wrapper instantiation
    adder_16bit uut(
        .a(adder_16bit_if_inst.a),
        .b(adder_16bit_if_inst.b),
        .Cin(adder_16bit_if_inst.Cin),
        .y(adder_16bit_if_inst.y),
        .Co(adder_16bit_if_inst.Co)
    );
    
    initial begin
        // Set the interface as config object in UVM database
        uvm_config_db #(virtual adder_16bit_if)::set(null, "*", "vif", adder_16bit_if_inst);
        $dumpfile("dump.vcd"); 
        $dumpvars;    
    end

    initial begin
        run_test("adder_16bit_test");
    end
    
endmodule