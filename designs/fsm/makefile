# include ../../common.mk


BASE_DIR = ../..

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

all: build

build:
		$(SCRIPT) $(ARGS) $(FILE_LIST) $(OPTS)
		rm -rf npiLog

vcs:
		vcs -sverilog +v2k -timescale=1ns/1ns       \
		-debug_all         							\
		-l compile.log 								\
		${TEST_DESIGN}.v testbench.v

sim:
		./simv -l run.log

clean: clean_build clean_sim

clean_build:
			rm -rf npiLog
			rm -rf __pycache__
			rm -f *.sv
			rm -rf *.f

clean_sim:
		rm -rf *.log  csrc  simv*  *.key *.vpd  DVEfiles coverage *.vdb output.txt
