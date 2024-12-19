// driver.sv
class alu_driver extends uvm_driver #(alu_trans);
  `uvm_component_utils(alu_driver)

  virtual alu_if vif;
  uvm_analysis_port #(alu_trans) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    alu_trans trans;
    forever begin
      seq_item_port.get_next_item(trans);
      drive_item(trans);
      seq_item_port.item_done();
    end
  endtask

  task drive_item(alu_trans trans);
    vif.a <= trans.a;
    vif.b <= trans.b;
    vif.aluc <= trans.aluc;
    #1;
    trans.r = vif.r;
    trans.zero = vif.zero;
    trans.carry = vif.carry;
    trans.negative = vif.negative;
    trans.overflow = vif.overflow;
    trans.flag = vif.flag;
    uvm_report_info("DRV", $sformatf("Driving transaction:\na=%0h, b=%0h, aluc=%0h", trans.a, trans.b, trans.aluc));
    uvm_report_info("DRV", $sformatf("Received transaction:\nr=%0h, zero=%0b, carry=%0b, negative=%0b, overflow=%0b, flag=%0b", trans.r, trans.zero, trans.carry, trans.negative, trans.overflow, trans.flag));
    analysis_port.write(trans);
  endtask
endclass