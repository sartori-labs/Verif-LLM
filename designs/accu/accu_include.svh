`include "uvm_macros.svh"
import uvm_pkg::*;

`ifdef CodeLt1
    `include "../../_codel/t1/accu_tb/accu_pkg.sv"
`elsif CodeLt2
    `include "../../_codel/t2/accu_tb/accu_pkg.sv"  
`elsif Gemmat1
    `include "../../_gemma2/t1/accu_tb/accu_pkg.sv"
`elsif Gemmat2
    `include "../../_gemma2/t2/accu_tb/accu_pkg.sv"
`elsif GPTt1
    `include "../../_chatgpt4o/t1/accu_tb/accu_pkg.sv"
`elsif GPTt2
    `include "../../_chatgpt4o/t2/accu_tb/accu_pkg.sv"
`endif