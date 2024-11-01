// adder_16bit_agent.sv
`ifndef ADDER_16BIT_AGENT_SV
`define ADDER_16BIT_AGENT_SV

class adder_16bit_agent extends uvm_agent;
    `uvm_component_utils(adder_16bit_agent)

    adder_16bit_sequencer seqr;
    adder_16bit_driver drv;
    adder_16bit_monitor mon;
    virtual adder_16bit_if vif;

    function new(string name = "adder_16bit_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr = adder_16bit_sequencer::type_id::create("seqr", this);
        drv = adder_16bit_driver::type_id::create("drv", this);
        mon = adder_16bit_monitor::type_id::create("mon", this);

        if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found")

        drv.vif = vif;
        mon.vif = vif;
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
        mon.ap.connect(drv.ap);
    endfunction
endclass

`endif // ADDER_16BIT_AGENT_SV
