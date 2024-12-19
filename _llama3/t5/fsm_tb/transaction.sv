// fsm_trans.sv
class fsm_trans extends uvm_sequence_item;
    `uvm_object_utils(fsm_trans)

    rand logic IN;
    logic MATCH;

    constraint IN_constraint {IN dist {0:=5, 1:=5};}

    function new(string name = "fsm_trans");
        super.new(name);
    endfunction

endclass