// Driver class
class adder_16bit_driver extends uvm_driver#(adder_16bit_trans);
    `uvm_component_utils(adder_16bit_driver)

    uvm_analysis_port#(adder_16bit_trans) analysis_port; // Declare analysis port

    virtual adder_16bit_if vif;

    function new(string name = "adder_16bit_driver", uvm_component parent = null);
        super.new(name, parent);
        analysis_port = new("analysis_port", this); // Initialize analysis port
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
    endfunction

    task run_phase(uvm_phase phase);
        adder_16bit_trans trans;
        forever begin
            seq_item_port.get_next_item(trans);
            drive_item(trans);
            analysis_port.write(trans); // Send transaction to analysis port
            seq_item_port.item_done();
        end
    endtask

    task drive_item(adder_16bit_trans trans);
        vif.a = trans.a;
        vif.b = trans.b;
        vif.Cin = trans.Cin;
        @(posedge vif.clk);
        trans.y = vif.y;
        trans.Co = vif.Co;
    endtask

endclass