// Monitor class for 8-bit adder
class adder_8bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_8bit_monitor)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_transaction) ap;

  function new(string name = "adder_8bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      // Initialize the transaction object before the clock edge
      adder_8bit_transaction trans = adder_8bit_transaction::type_id::create("trans", this);

      @(posedge vif.clk);

      // Sample values after the clock edge
      trans.a = vif.a;
      trans.b = vif.b;
      trans.cin = vif.cin;
      trans.sum = vif.sum;
      trans.cout = vif.cout;

      // Send the captured data to the analysis port
      ap.write(trans);
    end
  endtask
endclass
