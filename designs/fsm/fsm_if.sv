interface fsm_if(input logic CLK, input logic RST);
    logic IN;
    logic MATCH;
	
	// input covergroup
	covergroup cg_inputs () @ (posedge CLK && !RST);
		IN_stim: coverpoint IN {
			bins max = { 1 };
			bins min = { 0 };
			bins s0 = (0 => 0 => 0);
			bins s1 = (0 => 0 => 1);
			bins s2 = (0 => 1 => 0);
			bins s3 = (0 => 1 => 1);
			bins s4 = (1 => 0 => 0);
			bins s5 = (1 => 0 => 1);
			bins other = default sequence;	
		}
		
	endgroup
	
	cg_inputs cg_inputs_inst = new();
	
endinterface