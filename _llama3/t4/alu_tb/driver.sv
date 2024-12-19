
// alu_driver.sv
class alu_driver extends uvm_driver#(alu_trans);
  `uvm_component_utils(alu_driver)

  virtual alu_if alu_vi;

  function new(string name = "alu_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vi", alu_vi))
      `uvm_fatal("NO_VIF", "Failed to get virtual interface")
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
    @(posedge alu_vi.clk)
    alu_vi.a <= trans.a;
    alu_vi.b <= trans.b;
    alu_vi.aluc <= trans.aluc;
  endtask
endclass