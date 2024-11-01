// UVM Sequencer Class
class accu_sequencer extends uvm_sequencer #(accu_transaction);
    `uvm_component_utils(accu_sequencer)

    function new(string name = "accu_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass