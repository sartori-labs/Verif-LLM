// Sequencer Class
class adder_8bit_sequencer extends uvm_sequencer #(adder_8bit_trans);
    `uvm_component_utils(adder_8bit_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass