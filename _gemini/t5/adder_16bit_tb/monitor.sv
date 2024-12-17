// adder_16bit_monitor.sv
class adder_16bit_monitor extends uvm_monitor;
  `uvm_component_utils(adder_16bit_monitor)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_transaction) analysis_port;

  function new(string name = "adder_16bit_monitor", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("ADDER_MON", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      adder_16bit_transaction trans;
      trans = adder_16bit_transaction::type_id::create("trans");
      #10; // Wait for some time to sample the output
      trans.a = vif.a;
      trans.b = vif.b;
      trans.Cin = vif.Cin;
      trans.y = vif.y;
      trans.Co = vif.Co;
      `uvm_info("ADDER_MON", $sformatf("Observed transaction: a=0x%h b=0x%h Cin=%b y=0x%h Co=%b", trans.a, trans.b, trans.Cin, trans.y, trans.Co), UVM_MEDIUM)
      analysis_port.write(trans);
    end
  endtask
endclass