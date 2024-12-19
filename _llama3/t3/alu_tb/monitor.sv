class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if alu_vi;
  uvm_analysis_port#(alu_trans) item_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_port = new("item_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vi", alu_vi)) begin
      `uvm_fatal("NO_VIF", "Failed to get virtual interface from config DB")
    end
  endfunction

task run_phase(uvm_phase phase);
  alu_trans trans;
  forever begin
    @(posedge alu_vi.clk);
    trans = alu_trans::type_id::create("trans");
    trans.r = alu_vi.r;
    trans.zero = alu_vi.zero;
    trans.carry = alu_vi.carry;
    trans.negative = alu_vi.negative;
    trans.overflow = alu_vi.overflow;
    trans.flag = alu_vi.flag;
    item_port.write(trans);
  end
endtask
endclass