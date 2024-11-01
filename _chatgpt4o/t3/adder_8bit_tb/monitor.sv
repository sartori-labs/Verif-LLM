class adder_8bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_8bit_monitor)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_transaction) ap;

  function new(string name = "adder_8bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_8bit_transaction tr = adder_8bit_transaction::type_id::create("tr");
      @(posedge vif.clk);
      tr.a = vif.a;
      tr.b = vif.b;
      tr.cin = vif.cin;
      tr.sum = vif.sum;
      tr.cout = vif.cout;
      ap.write(tr);
    end
  endtask
endclass
