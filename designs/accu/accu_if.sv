interface accu_if(input logic clk, input logic rst_n);
        
    logic   [7:0]   data_in;     
    logic           valid_in;    
 
    logic           valid_out;   
    logic   [9:0]   data_out;

endinterface