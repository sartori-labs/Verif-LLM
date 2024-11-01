class adder_8bit_driver extends uvm_driver #(adder_8bit_transaction);
  `uvm_component_utils(adder_8bit_driver)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_transaction) ap;

  function new(string name = "adder_8bit_driver", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_8bit_transaction tr;
      seq_item_port.get_next_item(tr);
      vif.a = tr.a;
      vif.b = tr.b;
      vif.cin = tr.cin;
      @(posedge vif.clk); // Assuming a clock signal is present
      tr.sum = vif.sum;
      tr.cout = vif.cout;
      ap.write(tr);
      seq_item_port.item_done();
    end
  endtask
endclass
