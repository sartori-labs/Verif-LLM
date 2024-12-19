class fsm_trans extends uvm_sequence_item;
    `uvm_object_utils(fsm_trans)

    rand bit IN;
    bit MATCH;

    constraint IN_constraint {IN dist {0:=1, 1:=1};}

    function new(string name = "fsm_trans");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        fsm_trans rhs_;
        assert($cast(rhs_, rhs));
        IN = rhs_.IN;
        MATCH = rhs_.MATCH;
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        fsm_trans rhs_;
        assert($cast(rhs_, rhs));
        return (IN == rhs_.IN) && (MATCH == rhs_.MATCH);
    endfunction

    function string convert2string();
        return $sformatf("IN=%0d, MATCH=%0d", IN, MATCH);
    endfunction
endclass