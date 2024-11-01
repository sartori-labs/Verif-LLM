`include "uvm_macros.svh"
import uvm_pkg::*;

`ifdef DEFAULT
    `include "./testbench/adder_16bit_pkg.sv"
`elsif CodeLt1
    `include "../../_codel/t1/adder_16bit_tb/adder_16bit_pkg.sv"
`elsif CodeLt2
    `include "../../_codel/t2/adder_16bit_tb/adder_16bit_pkg.sv"  
`elsif Gemmat1
    `include "../../_gemma2/t1/adder_16bit_tb/adder_16bit_pkg.sv"
`elsif Gemmat2
    `include "../../_gemma2/t2/adder_16bit_tb/adder_16bit_pkg.sv"
`elsif GPTt1
    `include "../../_chatgpt4o/t1/adder_16bit_tb/adder_16bit_pkg.sv"
`elsif GPTt2
    `include "../../_chatgpt4o/t2/adder_16bit_tb/adder_16bit_pkg.sv"
`endif