interface alu_if(input logic clk, input logic rst);
    logic [31:0] a;
    logic [31:0] b;
    logic [5:0] aluc;
    logic [31:0] r;
    logic zero;
    logic carry;
    logic negative;
    logic overflow;
    logic flag;
    // input covergroup
	covergroup cg_inputs () @ (posedge clk && !rst);
		a_stim: coverpoint a {
			bins max = { 2**32 - 1} ;
			bins min = { 0 };
			bins all[5] = { [0:2**32 - 1] };
		}
		
		b_stim: coverpoint b {
			bins max = { 2**32 -1 };
			bins min = { 0 };
			bins all[5] = { [0:2**32 - 1] };
		}
		aluc_stim: coverpoint aluc {
			bins ADD =  {6'b100000};
			bins ADDU = {6'b100001};
			bins SUB =  {6'b100010};
			bins SUBU = {6'b100011};
			bins AND =  {6'b100100};
			bins OR =   {6'b100101};
			bins XOR =  {6'b100110};
			bins NOR =  {6'b100111};
			bins SLT =  {6'b101010};
			bins SLTU = {6'b101011};
			bins SLL =  {6'b000000};
			bins SRL =  {6'b000010};
			bins SRA =  {6'b000011};
			bins SLLV = {6'b000100};
			bins SRLV = {6'b000110};
			bins SRAV = {6'b000111};
			bins JR =   {6'b001000};
			bins LUI =  {6'b001111};
			bins OTHER = default;
		}
		full_stim: cross a_stim, b_stim, aluc_stim {
			bins all = binsof(a_stim.all) && binsof(b_stim.all) && binsof(aluc_stim);
		}
	endgroup
	cg_inputs cg_inputs_inst = new();
endinterface