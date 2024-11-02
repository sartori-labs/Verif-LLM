interface accu_if(input logic clk, input logic rst_n);
        
    logic   [7:0]   data_in;     
    logic           valid_in;    
 
    logic           valid_out;   
    logic   [9:0]   data_out;

    // input covergroup
	covergroup cg_inputs () @ (posedge clk && rst_n);
		data_in_stim: coverpoint data_in {
			bins max = { 2**8 - 1 };
			bins min = { 0} ;
			bins all[5] = { [0:2**8 - 1] };
		}
		
		valid_in_stim: coverpoint valid_in {
			bins max = { 1 };
			bins min = { 0 };
			bins all[] = { 0,1 };
		}
		
		full_stim: cross data_in_stim, valid_in_stim {
			bins all = binsof(data_in_stim.all) && binsof(valid_in_stim.all);
		}
		
	endgroup
	
	cg_inputs cg_inputs_inst = new();
    
endinterface