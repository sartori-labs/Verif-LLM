`include "uvm_macros.svh"
import uvm_pkg::*;

`ifdef DEFAULT
    `include "./testbench/adder_8bit_pkg.sv"
`elsif CodeLt1
    `include "../../_llama3/t1/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif CodeLt2
    `include "../../_llama3/t2/adder_8bit_tb/adder_8bit_pkg.sv"  
`elsif CodeLt3
    `include "../../_llama3/t3/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif CodeLt4
    `include "../../_llama3/t4/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif CodeLt5
    `include "../../_llama3/t5/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif Gemmat1
    `include "../../_gemini/t1/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif Gemmat2
    `include "../../_gemini/t2/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif Gemmat3
    `include "../../_gemini/t3/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif Gemmat4
    `include "../../_gemini/t4/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif Gemmat5
    `include "../../_gemini/t5/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif GPTt1
    `include "../../_chatgpt4o/t1/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif GPTt2
    `include "../../_chatgpt4o/t2/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif GPTt3
    `include "../../_chatgpt4o/t3/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif GPTt4
    `include "../../_chatgpt4o/t4/adder_8bit_tb/adder_8bit_pkg.sv"
`elsif GPTt5
    `include "../../_chatgpt4o/t5/adder_8bit_tb/adder_8bit_pkg.sv"
`endif