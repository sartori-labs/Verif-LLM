// Monitor class
class adder_16bit_monitor extends uvm_monitor;
    `uvm_component_utils(adder_16bit_monitor)

    virtual adder_16bit_if vif;

    uvm_analysis_port#(adder_16bit_trans) analysis_port;

    function new(string name = "adder_16bit_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysis_port = new("analysis_port", this);
        if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
    endfunction

    task run_phase(uvm_phase phase);
        adder_16bit_trans trans;
        forever begin
            @(posedge vif.clk);
            trans = adder_16bit_trans::type_id::create("trans");
            trans.a = vif.a;
            trans.b = vif.b;
            trans.Cin = vif.Cin;
            @(negedge vif.clk);
            trans.y = vif.y;
            trans.Co = vif.Co;
            analysis_port.write(trans);
        end
    endtask

endclass
