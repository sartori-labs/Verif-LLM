# include ../../common.mk

BASE_DIR = ../..

UVM_HOME = ${VCS_HOME}/etc/uvm-ieee-2020-2.0

PYTHON = python3
SCRIPT = $(BASE_DIR)/scripts/run_main.py
ARGS = -sv 

OPTS = -npi_nl_rtl_opt DetailRTL+DetailMux+GenBlock

.PHONY: clean clean_build help coverage_report vcs sim euclide all build
.DEFAULT_GLOBAL := help


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

help: ## lists the self documenting help file commands
		@echo ''
		@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'
		@echo ''

all: build
all: ## makes all which is currently just build

build:
		$(SCRIPT) $(ARGS) $(FILE_LIST) $(OPTS)
		rm -rf npiLog

euclide: EUCLIDE_SWITCH = -euclide
euclide: EUCLIDE_ARGS = -euclide_args \
		$(EUCLIDE_VSCODE) \
		-project_location . -workspace ../workspace \
		-cud_entry "-property -r -ruleset ignore_all ${UVM_HOME}" -end_euclide_args
euclide: vcs
euclide: ## runs the "vcs" target with modification to run Synopsys EUCLIDE IDE

vcs: ## builds VCS simulation
		vcs $(EUCLIDE_SWITCH) \
		-cm line+cond+fsm+branch+assert+tgl -Mupdate +v2k -sverilog -timescale=1ns/10ps \
		+incdir+$(UVM_HOME)/src \
		-full64 \
		${UVM_HOME}/src/uvm.sv \
		${UVM_HOME}/src/dpi/uvm_dpi.cc \
		-l compile.log -debug_acc+all -CFLAGS -DVCS top.sv ./dut/$(TEST_DESIGN).v $(TEST_DESIGN)_if.sv \
		-top top \
		+vcs+dumpvars+verilog.vpd $(EUCLIDE_ARGS)

sim: ## runs VCS simulation
		./simv -cm line+cond+fsm+branch+assert+tgl -l run.log 

coverage_report: ## runs VCS coverage report
		urg -dir simv.vdb -format text -show ratios
		cat urgReport/dashboard.txt

clean: clean_build clean_sim clean_euclide
clean: ## does clean_build, clean_sim and clean_euclide

clean_build: ## cleans the python output
			rm -rf npiLog
			rm -rf __pycache__

clean_sim: ## cleans the simulation output
		rm -rf *.log  csrc *.h simv* *.key *.vpd urgReport DVEfiles coverage *.vcs *.vcd *.vdb output.txt .fsm.sch.verilog.xml simv.daidir vc_hdrs.h vdCov.conf vdCovLog novas.rc ucli.key

clean_euclide: ## cleans the Synopsys Euclide output
		rm -rf EUAN.list EUELAB.DB compilation_unit_elab.cud

