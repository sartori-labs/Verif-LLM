// Sequence Class
class adder_8bit_sequence extends uvm_sequence #(adder_8bit_transaction);
    `uvm_object_utils(adder_8bit_sequence)

    function new(string name = "adder_8bit_sequence");
        super.new(name);
    endfunction

    task body();
        adder_8bit_transaction trans;
        for (int i = 0; i < 100; i++) begin
            trans = adder_8bit_transaction::type_id::create("trans");
            assert(trans.randomize());
            start_item(trans);
            finish_item(trans);
        end
    endtask
endclass