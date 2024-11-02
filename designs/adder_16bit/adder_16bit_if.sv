interface adder_16bit_if(input logic clk, input logic rst);
    logic [15:0] a;
    logic [15:0] b;
    logic Cin;
    logic [15:0] y;
    logic Co;

    // input covergroup
	covergroup cg_inputs () @ (posedge clk && !rst);
		a_stim: coverpoint a {
			bins max = { 2**16 - 1 };
			bins min = { 0 };
			bins all[5] = { [0:2**16 - 1] };
		}
		
		b_stim: coverpoint b {
			bins max = { 2**16 - 1 };
			bins min = { 0 };
			bins all[5] = { [0:2**16 - 1] };
		}
		
		cin_stim: coverpoint Cin {
			bins max = { 1 };
			bins min = { 0 };
			bins all[] = { 0,1 };
		}
		
		full_stim: cross a_stim, b_stim, cin_stim {
			bins all = binsof(a_stim.all) && binsof(b_stim.all) && binsof(cin_stim.all);
		}
		
	endgroup
	
	cg_inputs cg_inputs_inst = new();
endinterface