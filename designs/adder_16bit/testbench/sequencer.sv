class adder_16bit_sequencer extends uvm_sequencer #(adder_16bit_trans);
    
    // Utility Macro 
    `uvm_component_utils (adder_16bit_sequencer);
    
    // Constructor 
    function new (string name = "adder_16bit_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
endclass