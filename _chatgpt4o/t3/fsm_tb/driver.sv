// fsm_driver.sv
class fsm_driver extends uvm_driver #(fsm_transaction);
  `uvm_component_utils(fsm_driver)

  virtual fsm_if vif;
  uvm_analysis_port #(fsm_transaction) ap;

  function new(string name = "fsm_driver", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fsm_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    fsm_transaction tr;
    forever begin
      seq_item_port.get_next_item(tr);
      vif.IN <= tr.IN;
      @(posedge vif.CLK);
      tr.MATCH = vif.MATCH;
      ap.write(tr);
      seq_item_port.item_done();
    end
  endtask
endclass
