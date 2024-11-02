// interface for adder_8bit
interface adder_8bit_if(input logic clk, input logic rst);
    logic [7:0] a;
    logic [7:0] b;
    logic cin;
    logic [7:0] sum;
    logic cout;
	
	// input covergroup
	covergroup cg_inputs () @ (posedge clk && !rst);
		a_stim: coverpoint a {
			bins max = {255};
			bins min = {0};
			bins all[5] = {[0:255]};
		}
		
		b_stim: coverpoint b {
			bins max = {255};
			bins min = {0};
			bins all[5] = {[0:255]};
		}
		
		cin_stim: coverpoint cin {
			bins max = {1};
			bins min = {0};
			bins all[] = {0,1};
		}
		
		full_stim: cross a_stim, b_stim, cin_stim {
			bins all = binsof(a_stim.all) && binsof(b_stim.all) && binsof(cin_stim.all);
		}
		
	endgroup
	
	cg_inputs cg_inputs_inst = new();
	
endinterface
