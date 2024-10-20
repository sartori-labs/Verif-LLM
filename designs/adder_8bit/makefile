# include ../../common.mk


BASE_DIR = ../..

UVM_HOME = ${VCS_HOME}/etc/uvm-ieee-2020-2.0

PYTHON = python3
SCRIPT = $(BASE_DIR)/scripts/run_main.py
ARGS = -sv 

OPTS = -npi_nl_rtl_opt DetailRTL+DetailMux+GenBlock

.PHONY: vcs build sim clean

# Get the name of the current directory
TEST_DESIGN := $(shell basename $(shell pwd))

# File extensions to find
EXTENSIONS := .v .sv .vhd

# Targets to hold the found files
V_FILES := $(shell find dut -type f -name "*.v")
SV_FILES := $(shell find dut -type f -name "*.sv")
VHD_FILES := $(shell find dut -type f -name "*.vhd")

# Combined target to hold all files
FILE_LIST = $(V_FILES) $(SV_FILES) $(VHD_FILES)

# switches to enable the VCS command line to launch in Synopsys Euclide IDE
EUCLIDE_SWITCH =
EUCLIDE_ARGS =
EUCLIDE_VSCODE =

all: build

build:
		$(SCRIPT) $(ARGS) $(FILE_LIST) $(OPTS)
		rm -rf npiLog

# "euclide" Target wraps the "vcs" target 
euclide: EUCLIDE_SWITCH = -euclide
euclide: EUCLIDE_ARGS = -euclide_args \
		$(EUCLIDE_VSCODE) \
		-project_location . -workspace ../workspace \
		-cud_entry "-property -r -ruleset ignore_all ${UVM_HOME}" -end_euclide_args
euclide: vcs

vcs:
		vcs $(EUCLIDE_SWITCH) \
		-cm line+cond+fsm+branch+tgl -Mupdate +v2k -sverilog -timescale=1ns/10ps \
		+incdir+$(UVM_HOME)/src \
		${UVM_HOME}/src/uvm.sv \
		${UVM_HOME}/src/dpi/uvm_dpi.cc \
		-l compile.log -debug_acc+all -CFLAGS -DVCS top.sv ./dut/$(TEST_DESIGN).v $(TEST_DESIGN)_if.sv \
		-top top \
		+vcs+dumpvars+verilog.vpd $(EUCLIDE_ARGS)

sim:
		./simv -cm line+cond+fsm+branch+tgl -l run.log 

clean: clean_build clean_sim

clean_build:
			rm -rf npiLog
			rm -rf __pycache__

clean_sim:
		rm -rf *.log  csrc *.h simv* *.key *.vpd  DVEfiles coverage *.vcs *.vcd *.vdb output.txt .fsm.sch.verilog.xml
