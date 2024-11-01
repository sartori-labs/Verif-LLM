// Driver class for 8-bit adder
class adder_8bit_driver extends uvm_driver #(adder_8bit_transaction);
  `uvm_component_utils(adder_8bit_driver)

  virtual adder_8bit_if vif;
  uvm_analysis_port #(adder_8bit_transaction) ap;

  function new(string name = "adder_8bit_driver", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_8bit_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_8bit_transaction trans;
      seq_item_port.get_next_item(trans);

      // Drive signals on the interface
      vif.a <= trans.a;
      vif.b <= trans.b;
      vif.cin <= trans.cin;

      // Wait for one clock cycle
      @(posedge vif.clk);

      // Capture outputs from the DUT
      trans.sum = vif.sum;
      trans.cout = vif.cout;

      // Send transaction to the analysis port for the scoreboard
      ap.write(trans);

      seq_item_port.item_done();
    end
  endtask
endclass
