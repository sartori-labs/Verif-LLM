// Monitor class
class accu_monitor extends uvm_monitor;
  `uvm_component_utils(accu_monitor)

  virtual accu_if vif;
  uvm_analysis_port#(accu_trans) item_collected_port;

  function new(string name = "accu_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual accu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Failed to get virtual interface")
    end
  endfunction

  task run_phase(uvm_phase phase);
    accu_trans trans;
    forever begin
      @(posedge vif.clk);
      trans = accu_trans::type_id::create("trans");
      trans.data_in = vif.data_in;
      trans.valid_in = vif.valid_in;
      trans.data_out = vif.data_out;
      trans.valid_out = vif.valid_out;
      item_collected_port.write(trans);
    end
  endtask
endclass
