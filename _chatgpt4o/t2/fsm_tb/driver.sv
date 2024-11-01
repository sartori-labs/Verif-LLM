class driver_fsm extends uvm_driver #(trans_fsm);
  `uvm_component_utils(driver_fsm)

  virtual fsm_if vif;

  function new(string name = "driver_fsm", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    trans_fsm tr;
    forever begin
      seq_item_port.get_next_item(tr);
      vif.IN <= tr.IN;
      @(posedge vif.CLK);
      tr.MATCH = vif.MATCH; // Capture output
      seq_item_port.item_done();
    end
  endtask
endclass
