// Agent class
class accu_agent extends uvm_agent;
    accu_driver driver;
    accu_sequencer sequencer;
    accu_monitor monitor;
    virtual accu_if vif;

    `uvm_component_utils(accu_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequencer = accu_sequencer::type_id::create("sequencer", this);
        driver = accu_driver::type_id::create("driver", this);
        monitor = accu_monitor::type_id::create("monitor", this);
        if (!uvm_config_db#(virtual accu_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
        driver.vif = vif;
        monitor.vif = vif;
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass