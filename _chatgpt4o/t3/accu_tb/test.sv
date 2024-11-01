// UVM Test Class
class accu_test extends uvm_test;
    `uvm_component_utils(accu_test)

    accu_env env;
    accu_sequence seq;

    function new(string name = "accu_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = accu_env::type_id::create("env", this);
        seq = accu_sequence::type_id::create("seq");
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agt.seqr);
        phase.drop_objection(this);
    endtask
endclass