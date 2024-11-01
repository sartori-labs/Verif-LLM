// Transaction Class
class adder_8bit_trans extends uvm_sequence_item;
    `uvm_object_utils(adder_8bit_trans)
    
    rand bit [7:0] a;
    rand bit [7:0] b;
    rand bit cin;
    bit [7:0] sum;
    bit cout;
    
    function new(string name = "adder_8bit_trans");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        `uvm_info("TRANSACTION INFO", $sformatf("a=%0h, b=%0h, cin=%0b, sum=%0h, cout=%0b", a, b, cin, sum, cout), UVM_LOW)
    endfunction
endclass