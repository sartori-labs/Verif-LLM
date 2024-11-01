// Sequencer class
class accu_sequencer extends uvm_sequencer #(accu_transaction);
    `uvm_component_utils(accu_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass