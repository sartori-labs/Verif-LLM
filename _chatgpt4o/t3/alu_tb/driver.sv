// alu_driver.sv - Driver Class
class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)

  virtual alu_if vif;
  uvm_analysis_port #(alu_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      alu_transaction tx;
      seq_item_port.get_next_item(tx);

      // Drive inputs
      vif.a <= tx.a;
      vif.b <= tx.b;
      vif.aluc <= tx.aluc;
      @(posedge vif.clk);  // Wait for clock edge

      // Collect outputs
      tx.r = vif.r;
      tx.zero = vif.zero;
      tx.carry = vif.carry;
      tx.negative = vif.negative;
      tx.overflow = vif.overflow;
      tx.flag = vif.flag;

      // Send to analysis port
      ap.write(tx);
      seq_item_port.item_done();
    end
  endtask
endclass