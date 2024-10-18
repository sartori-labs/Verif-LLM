class adder_8bit_sequence extends uvm_sequence #(adder_8bit_trans);

    // Utility Macro 
    `uvm_object_utils (adder_8bit_sequence);

    // Declare the transaction(s)
    adder_8bit_trans trans;

    // Constructor 
    function new (string name = "adder_8bit_sequence");
        super.new(name);
    endfunction : new

    // Called before the body() task
    virtual task pre_body();
        `uvm_info("ADDER_8BIT_SEQ", $sformatf("Optional code can be placed here in pre_body()"), UVM_MEDIUM)
        if(starting_phase != null)
            starting_phase.raise_objection(this);
    endtask : pre_body

    // Main task of the sequence
    // Make this "virtual" so that child classes can over-ride this task definition
    virtual task body();
        `uvm_info("ADDER_8BIT_SEQ", $sformatf("Starting body of %s", this.get_name()), UVM_MEDIUM)

        trans = adder_8bit_trans::type_id::create("trans");
        for (int i = 0; i < 10; i++) begin
            start_item(trans);
            `uvm_info("ADDER_SEQ", $sformatf("Randomizing transaction %0d", i), UVM_MEDIUM)
            
            assert(trans.randomize()) else `uvm_error("RANDOMIZE_FAIL", "Randomization failed")
            
            `uvm_info("ADDER_SEQ", $sformatf("Transaction %0d: %s", i, trans.convert2string()), UVM_MEDIUM)
           
            finish_item(trans);
        end
        `uvm_info(get_type_name(), $sformatf("Sequence %s is over", this.get_name()), UVM_MEDIUM)
    endtask : body

    // Called after body() task
    virtual task post_body();
        `uvm_info("ADDER_8BIT_SEQ", $sformatf("Optional code can be placed here in post_body()"), UVM_MEDIUM)
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : post_body
    
endclass