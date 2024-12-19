// Sequencer class
class adder_16bit_sequencer extends uvm_sequencer #(adder_16bit_trans);
    `uvm_component_utils(adder_16bit_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass