// alu_monitor.sv
class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)

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
            @(posedge alu_vi.clk);
            trans = new("trans");
            trans.a = alu_vi.a;
            trans.b = alu_vi.b;
            trans.aluc = alu_vi.aluc;
            @(negedge alu_vi.clk);
            trans.r = alu_vi.r;
            trans.zero = alu_vi.zero;
            trans.carry = alu_vi.carry;
            trans.negative = alu_vi.negative;
            trans.overflow = alu_vi.overflow;
            trans.flag = alu_vi.flag;
            analysis_port.write(trans);
        end
    endtask
endclass
