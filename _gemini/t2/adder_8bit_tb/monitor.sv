// adder_8bit_monitor.sv
class adder_8bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_8bit_monitor)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_transaction) analysis_port;

  function new(string name = "adder_8bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif)) begin
      `uvm_error("ADDER_MONITOR", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      adder_8bit_transaction trans;
      #10; // Wait for some time to sample the output
      trans = adder_8bit_transaction::type_id::create("trans");
      trans.a = vif.a;
      trans.b = vif.b;
      trans.cin = vif.cin;
      trans.sum = vif.sum;
      trans.cout = vif.cout;
      `uvm_info("ADDER_MON", $sformatf("Observed transaction: a=0x%h, b=0x%h, cin=%b, sum=0x%h, cout=%b", trans.a, trans.b, trans.cin, trans.sum, trans.cout), UVM_MEDIUM)
      analysis_port.write(trans);
    end
  endtask
endclass