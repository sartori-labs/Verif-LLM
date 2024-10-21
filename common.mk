BASE_DIR = ../..

UVM_HOME = ${VCS_HOME}/etc/uvm-1.2/

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
		urg -full64 \
			-dir simv.vdb \
			-format text \
			-show ratios \
			-xml_verbose \
			-xmlplan \
			-warn none \

coverage_summary: # grabs summary information from a coverage run
	@xmllint --xpath '/session/old_coverage/scope[@name="top"]/scope[@name="uut"]/metric[@name="Toggle"]/@value' urgReport/session.xml | awk -F\" '{ print "Toggle " $$2 }' | sed 's/XPath set is empty/Toggle None/g'
	@xmllint --xpath '/session/old_coverage/scope[@name="top"]/scope[@name="uut"]/metric[@name="Cond"]/@value' urgReport/session.xml | awk -F\" '{ print "Cond " $$2 }' | sed 's/XPath set is empty/Cond None/g'
	@xmllint --xpath '/session/old_coverage/scope[@name="top"]/scope[@name="uut"]/metric[@name="Line"]/@value' urgReport/session.xml | awk -F\" '{ print "Line " $$2 }' | sed 's/XPath set is empty/Line None/g'
	@xmllint --xpath '/session/old_coverage/scope[@name="top"]/scope[@name="uut"]/metric[@name="FSM"]/@value' urgReport/session.xml | awk -F\" '{ print "FSM " $$2 }' | sed 's/XPath set is empty/FSM None/g'
	@xmllint --xpath '/session/old_coverage/scope[@name="top"]/scope[@name="uut"]/metric[@name="Branch"]/@value' urgReport/session.xml | awk -F\" '{ print "Branch " $$2 }' | sed 's/XPath set is empty/Branch None/g'
#	@xmllint --xpath '/session/old_coverage/scope[@name="top"]/scope[@name="uut"]/metric[@name="Assert"]/@value' urgReport/session.xml | awk -F\" '{ print $$2 }' | sed s/XPath set is empty//g
	@xmllint --xpath '/session/old_coverage/scope[@type="Groups"]/attr[@type="Group Summary"]/@value' urgReport/session.xml | awk -F\" '{ print "CoverGroup " $$2 }' | sed 's/XPath set is empty/CoverGroup None/g'
	@xmllint --xpath '/session/old_coverage/scope[@name="Statistics"]/scorelist[1]/score[@name="Assert"]/@value' urgReport/session.xml | awk -F\" '{ print "Assert " $$2 }' | sed 's/XPath set is empty/Assert None/g'

clean: clean_build clean_sim clean_euclide
clean: ## does clean_build, clean_sim and clean_euclide

clean_build: ## cleans the python output
			rm -rf npiLog
			rm -rf __pycache__

clean_sim: ## cleans the simulation output
		rm -rf *.log  csrc *.h simv* *.key *.vpd urgReport DVEfiles coverage *.vcs *.vcd *.vdb output.txt .fsm.sch.verilog.xml simv.daidir vc_hdrs.h vdCov.conf vdCovLog novas.rc ucli.key

clean_euclide: ## cleans the Synopsys Euclide output
		rm -rf EUAN.list EUELAB.DB compilation_unit_elab.cud ../workspace

