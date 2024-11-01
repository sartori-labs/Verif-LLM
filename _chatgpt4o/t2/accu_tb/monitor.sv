class accu_monitor extends uvm_monitor;
  `uvm_component_utils(accu_monitor)

  virtual accu_if vif;
  uvm_analysis_port #(accu_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual accu_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface not set for monitor")
  endfunction

  task run_phase(uvm_phase phase);
    accu_transaction trans; // Declaration outside the loop

    forever begin
      @(posedge vif.clk); // Using `@posedge` for synchronization
      trans = accu_transaction::type_id::create("trans");

      trans.data_in = vif.data_in;
      trans.valid_in = vif.valid_in;

      ap.write(trans);
    end
  endtask
endclass
