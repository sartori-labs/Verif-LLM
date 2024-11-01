// Monitor Class
class adder_8bit_monitor extends uvm_monitor;
    `uvm_component_utils(adder_8bit_monitor)

    virtual adder_8bit_if vif;
    uvm_analysis_port #(adder_8bit_trans) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            adder_8bit_trans trans = adder_8bit_trans::type_id::create("trans");
            
            // Initialize transaction before posedge of the clock
            trans.a = vif.a;
            trans.b = vif.b;
            trans.cin = vif.cin;

            @(posedge vif.clk);

            // Sample output values at posedge
            trans.sum = vif.sum;
            trans.cout = vif.cout;

            ap.write(trans);
        end
    endtask
endclass
