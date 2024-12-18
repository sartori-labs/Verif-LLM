// alu_driver.sv
class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)

  virtual alu_if vif;

  // Declare the analysis port
  uvm_analysis_port #(alu_transaction) analysis_port; 

  function new(string name = "alu_driver", uvm_component parent = null);
    super.new(name, parent);
    analysis_port = new("analysis_port", this); // Initialize the port
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_error("ALU_DRIVER", "Virtual interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      vif.a <= req.a;
      vif.b <= req.b;
      vif.aluc <= req.aluc;
      #10; // Delay for DUT to process
      seq_item_port.item_done();
      analysis_port.write(req); 
    end
  endtask
endclass