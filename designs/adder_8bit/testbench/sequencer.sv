class adder_8bit_sequencer extends uvm_sequencer #(adder_8bit_trans);
    
    // Utility Macro 
    `uvm_component_utils (adder_8bit_sequencer);
    
    // Constructor 
    function new (string name = "adder_8bit_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
endclass