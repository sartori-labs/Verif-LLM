// driver.sv
class alu_driver extends uvm_driver#(alu_trans);
    `uvm_component_utils(alu_driver)

    virtual alu_if alu_vi;
    uvm_analysis_port#(alu_trans) analysis_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vi", alu_vi))
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".alu_vi"});
    endfunction

    task run_phase(uvm_phase phase);
        alu_trans trans;
        forever begin
            seq_item_port.get_next_item(trans);
            drive_item(trans);
            analysis_port.write(trans);
            seq_item_port.item_done();
        end
    endtask

    task drive_item(alu_trans trans);
        @(posedge alu_vi.clk);
        alu_vi.a = trans.a;
        alu_vi.b = trans.b;
        alu_vi.aluc = trans.aluc;
    endtask
endclass