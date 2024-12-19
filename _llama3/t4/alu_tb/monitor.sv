// alu_monitor.sv
class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if alu_vi;
  uvm_analysis_port#(alu_trans) item_port;

  function new(string name = "alu_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_port = new("item_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vi", alu_vi))
      `uvm_fatal("NO_VIF", "Failed to get virtual interface")
  endfunction

  task run_phase(uvm_phase phase);
    alu_trans trans;
    forever begin
      // Create a new transaction
      trans = alu_trans::type_id::create("trans");

      // Sample the signals and fill in the transaction
      @(posedge alu_vi.clk);
      trans.a = alu_vi.a;
      trans.b = alu_vi.b;
      trans.aluc = alu_vi.aluc;

      // Wait for the result
      @(posedge alu_vi.clk);
      trans.r = alu_vi.r;

      // Send the transaction to the scoreboard
      item_port.write(trans);
    end
  endtask
endclass