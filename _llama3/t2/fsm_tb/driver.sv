// Driver class
class fsm_driver extends uvm_driver#(fsm_trans);
  `uvm_component_utils(fsm_driver)

  virtual fsm_if vif;

  uvm_analysis_port#(fsm_trans) analysis_export;

  function new(string name = "fsm_driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    end
  endfunction

  task run_phase(uvm_phase phase);
    fsm_trans trans;
    forever begin
      seq_item_port.get_next_item(trans);
      drive_item(trans);
      seq_item_port.item_done();
    end
  endtask

  task drive_item(fsm_trans trans);
    vif.in <= trans.in;
    vif.rst_n <= trans.rst_n;
  endtask
endclass
