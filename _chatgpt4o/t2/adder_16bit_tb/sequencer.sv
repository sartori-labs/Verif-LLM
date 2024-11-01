// adder_16bit_sequencer.sv
`ifndef ADDER_16BIT_SEQUENCER_SV
`define ADDER_16BIT_SEQUENCER_SV

class adder_16bit_sequencer extends uvm_sequencer #(adder_16bit_transaction);
    `uvm_component_utils(adder_16bit_sequencer)

    function new(string name = "adder_16bit_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass

`endif // ADDER_16BIT_SEQUENCER_SV
