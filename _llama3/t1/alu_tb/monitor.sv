// Monitor class
class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual interface alu_if vif;

  uvm_analysis_port #(alu_trans) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name()})
  endfunction

  task run_phase(uvm_phase phase);
    alu_trans trans;

    forever begin
      @(posedge vif.clk);
      trans = alu_trans::type_id::create("trans");
      trans.r = vif.r;
      trans.zero = vif.zero;
      trans.carry = vif.carry;
      trans.negative = vif.negative;
      trans.overflow = vif.overflow;
      trans.flag = vif.flag;
      item_collected_port.write(trans);
    end
  endtask

endclass
