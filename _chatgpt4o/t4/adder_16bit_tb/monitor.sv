// adder_16bit_monitor.sv
class adder_16bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_16bit_monitor)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_txn) ap;

  function new(string name = "adder_16bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      adder_16bit_txn txn = adder_16bit_txn::type_id::create("txn");
      txn.a = vif.a;
      txn.b = vif.b;
      txn.Cin = vif.Cin;
      #1; // Sample outputs after delay
      txn.y = vif.y;
      txn.Co = vif.Co;
      ap.write(txn);
    end
  endtask
endclass