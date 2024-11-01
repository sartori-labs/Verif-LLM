module top;

    import fsm_pkg::*;

    // Declare clock and reset signals here and initialize them here
    bit CLK;
    bit RST;

    // Clock generation
    always #5 CLK = ~CLK;

    // Reset generation
    initial begin
        RST = 1;
        #20 RST = 0;
    end

    virtual fsm_if vif;
    // Instantiate the Interface and pass it to the design
    fsm_if fsm_if_inst (.CLK(CLK), .RST(RST));

    // DUT wrapper instantiation
    fsm uut(
        .IN(fsm_if_inst.IN),
        .MATCH(fsm_if_inst.MATCH),
        .CLK(fsm_if_inst.CLK),
        .RST(fsm_if_inst.RST)
    );
    
    initial begin
        // Set the interface as config object in UVM database
        uvm_config_db #(virtual fsm_if)::set(null, "*", "vif", fsm_if_inst);
        $dumpfile("dump.vcd"); 
        $dumpvars;    
    end

    initial begin
        run_test("fsm_test");
    end
    
endmodule