// Driver class
class adder_16bit_driver extends uvm_driver #(adder_16bit_trans);
  `uvm_component_utils(adder_16bit_driver)

  virtual adder_16bit_if vif;
  uvm_analysis_port #(adder_16bit_trans) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_16bit_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive_item(req);
      seq_item_port.item_done();
    end
  endtask

  virtual task drive_item(adder_16bit_trans trans);
    vif.a <= trans.a;
    vif.b <= trans.b;
    vif.Cin <= trans.Cin;
    #10;
    trans.y = vif.y;
    trans.Co = vif.Co;
    uvm_report_info("DRIVER", $sformatf("Driven transaction:\na = %0h, b = %0h, Cin = %0h, y = %0h, Co = %0h", trans.a, trans.b, trans.Cin, trans.y, trans.Co));
    analysis_port.write(trans);
  endtask

endclass
