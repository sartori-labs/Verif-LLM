// adder_16bit_driver.sv
`ifndef ADDER_16BIT_DRIVER_SV
`define ADDER_16BIT_DRIVER_SV

class adder_16bit_driver extends uvm_driver #(adder_16bit_transaction);
    `uvm_component_utils(adder_16bit_driver)

    virtual adder_16bit_if vif;
    uvm_analysis_port #(adder_16bit_transaction) ap;

    function new(string name = "adder_16bit_driver", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            adder_16bit_transaction trans;
            seq_item_port.get_next_item(trans);

            // Driving input signals
            vif.a = trans.a;
            vif.b = trans.b;
            vif.Cin = trans.Cin;
            #1; // Wait for simulation tick

            // Capturing output signals
            trans.y = vif.y;
            trans.Co = vif.Co;

            ap.write(trans);
            seq_item_port.item_done();
        end
    endtask
endclass

`endif // ADDER_16BIT_DRIVER_SV
