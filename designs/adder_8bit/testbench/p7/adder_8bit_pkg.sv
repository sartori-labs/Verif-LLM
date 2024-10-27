package adder_8bit_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Transaction item for adder_8bit
    class adder_8bit_transaction extends uvm_sequence_item;
        rand bit [7:0] a;
        rand bit [7:0] b;
        rand bit cin;
        bit [7:0] sum;
        bit cout;

        `uvm_object_utils(adder_8bit_transaction)

        function new(string name = "adder_8bit_transaction");
            super.new(name);
        endfunction
    endclass

    // Sequence for adder_8bit
    class adder_8bit_sequence extends uvm_sequence #(adder_8bit_transaction);
        `uvm_object_utils(adder_8bit_sequence)

        function new(string name = "adder_8bit_sequence");
            super.new(name);
        endfunction

        virtual task body();
            adder_8bit_transaction trans;
            trans = adder_8bit_transaction::type_id::create("trans");
            start_item(trans);
            if (!trans.randomize()) `uvm_fatal("RANDOMIZE_FAIL", "Randomization failed for transaction.")
            finish_item(trans);
        endtask
    endclass

    // Driver for adder_8bit
    class adder_8bit_driver extends uvm_driver #(adder_8bit_transaction);
        `uvm_component_utils(adder_8bit_driver)

        virtual adder_8bit_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "Virtual interface not set for driver")
        endfunction

        virtual task run_phase(uvm_phase phase);
            adder_8bit_transaction trans;
            forever begin
                seq_item_port.get_next_item(trans);
                vif.a = trans.a;
                vif.b = trans.b;
                vif.cin = trans.cin;
                @(posedge vif.clk); // Wait for one clock cycle
                trans.sum = vif.sum;
                trans.cout = vif.cout;
                seq_item_port.item_done();
            end
        endtask
    endclass

    // Monitor for adder_8bit
    class adder_8bit_monitor extends uvm_monitor;
        `uvm_component_utils(adder_8bit_monitor)

        virtual adder_8bit_if vif;
        uvm_analysis_port #(adder_8bit_transaction) ap;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db #(virtual adder_8bit_if)::get(this, "", "vif", vif))
                `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
            ap = new("ap", this);
        endfunction

        virtual task run_phase(uvm_phase phase);
            adder_8bit_transaction trans;
            forever begin
                trans = adder_8bit_transaction::type_id::create("trans");
                @(posedge vif.clk);
                trans.a = vif.a;
                trans.b = vif.b;
                trans.cin = vif.cin;
                trans.sum = vif.sum;
                trans.cout = vif.cout;
                ap.write(trans);
            end
        endtask
    endclass

    // Sequencer for adder_8bit
    class adder_8bit_sequencer extends uvm_sequencer #(adder_8bit_transaction);
        `uvm_component_utils(adder_8bit_sequencer)

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
    endclass

    // Agent for adder_8bit
    class adder_8bit_agent extends uvm_agent;
        `uvm_component_utils(adder_8bit_agent)

        adder_8bit_driver drv;
        adder_8bit_monitor mon;
        adder_8bit_sequencer seqr;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            drv = adder_8bit_driver::type_id::create("drv", this);
            mon = adder_8bit_monitor::type_id::create("mon", this);
            seqr = adder_8bit_sequencer::type_id::create("seqr", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            drv.seq_item_port.connect(seqr.seq_item_export);
        endfunction
    endclass

    // Environment for adder_8bit
    class adder_8bit_env extends uvm_env;
        `uvm_component_utils(adder_8bit_env)

        adder_8bit_agent agent;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agent = adder_8bit_agent::type_id::create("agent", this);
        endfunction
    endclass

    // Test for adder_8bit
    class adder_8bit_test extends uvm_test;
        `uvm_component_utils(adder_8bit_test)

        adder_8bit_env env;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env = adder_8bit_env::type_id::create("env", this);
        endfunction

        task run_phase(uvm_phase phase);
            adder_8bit_sequence seq;
            phase.raise_objection(this);
            seq = adder_8bit_sequence::type_id::create("seq");
            seq.start(env.agent.seqr);
            phase.drop_objection(this);
        endtask
    endclass

endpackage
