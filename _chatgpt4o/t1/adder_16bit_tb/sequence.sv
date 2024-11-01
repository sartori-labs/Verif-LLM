// Sequence class to generate multiple transactions
class adder_16bit_sequence extends uvm_sequence #(adder_16bit_transaction);
    `uvm_object_utils(adder_16bit_sequence)

    // Constructor
    function new(string name = "adder_16bit_sequence");
        super.new(name);
    endfunction

    // Body phase for generating transactions
    virtual task body();
        adder_16bit_transaction trans;
        for (int i = 0; i < 100; i++) begin  // Loop for coverage
            trans = adder_16bit_transaction::type_id::create("trans");
            start_item(trans);
            assert(trans.randomize());
            finish_item(trans);
        end
    endtask
endclass
