// adder_monitor.sv
class adder_monitor extends uvm_monitor;
  `uvm_component_utils(adder_monitor)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("adder_monitor", "Virtual interface not set")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_transaction trans;
      trans = adder_transaction::type_id::create("trans");

      @(posedge vif.Co);
      trans.a = vif.a;
      trans.b = vif.b;
      trans.Cin = vif.Cin;
      trans.y = vif.y;
      trans.Co = vif.Co;

      ap.write(trans);
    end
  endtask
endclass
