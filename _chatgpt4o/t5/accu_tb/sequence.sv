// Sequence class
class accu_sequence extends uvm_sequence #(accu_transaction);
    `uvm_object_utils(accu_sequence)

    function new(string name = "accu_sequence");
        super.new(name);
    endfunction

    task body();
    accu_transaction tr;
    for (int i = 0; i < 4; i++) begin
        tr = accu_transaction::type_id::create("tr");
        assert(tr.randomize());
        start_item(tr);
        finish_item(tr);
    end
endtask

endclass