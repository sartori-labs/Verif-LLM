class adder_16bit_trans extends uvm_sequence_item;
    
    // Controls and Signals
    rand bit [15:0] a;
    rand bit [15:0] b;
    rand bit Cin;
    bit [15:0] y;
    bit Co;
    
    // Utility and Field Marcos
    `uvm_object_utils_begin(adder_16bit_trans)
        `uvm_field_int(a,   UVM_ALL_ON)
        `uvm_field_int(b,   UVM_ALL_ON)
        `uvm_field_int(Cin, UVM_ALL_ON)
    `uvm_object_utils_end

    // Constructor: This is the standard code for all components
    function new (string name = "adder_16bit_trans");
        super.new(name);
    endfunction : new

    // Add constraints (if any)
    
    // Additional Functions go here
    function string convert2string();
        return $sformatf("a=%0h b=%0h cin=%0h sum=%0h cout=%0h", a, b, Cin, y, Co);
    endfunction : convert2string

endclass