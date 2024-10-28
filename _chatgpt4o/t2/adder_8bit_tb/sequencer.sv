`ifndef ADDER_8BIT_SEQUENCER_SV
`define ADDER_8BIT_SEQUENCER_SV

class adder_8bit_sequencer extends uvm_sequencer #(adder_8bit_trans);

    `uvm_component_utils(adder_8bit_sequencer)

    function new(string name = "adder_8bit_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass

`endif
