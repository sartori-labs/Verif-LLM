// Sequence class
class adder_8bit_sequence extends uvm_sequence #(adder_8bit_trans);
    `uvm_object_utils(adder_8bit_sequence)

    function new(string name = "adder_8bit_sequence");
        super.new(name);
    endfunction

    task body();
        repeat(100) begin
            req = adder_8bit_trans::type_id::create("req");
            start_item(req);
            assert(req.randomize());
            finish_item(req);
        end
    endtask
endclass
