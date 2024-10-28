`ifndef ADDER_8BIT_DRIVER_SV
`define ADDER_8BIT_DRIVER_SV

class adder_8bit_driver extends uvm_driver #(adder_8bit_trans);
    virtual adder_8bit_if vif;
    uvm_analysis_port #(adder_8bit_trans) analysis_port;

    `uvm_component_utils(adder_8bit_driver)

    function new(string name = "adder_8bit_driver", uvm_component parent = null);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRIVER", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        adder_8bit_trans trans;
        forever begin
            seq_item_port.get_next_item(trans);
            vif.a = trans.a;
            vif.b = trans.b;
            vif.cin = trans.cin;
            @(posedge vif.clk);
            trans.sum = vif.sum;
            trans.cout = vif.cout;
            analysis_port.write(trans);
            seq_item_port.item_done();
        end
    endtask
endclass

`endif
