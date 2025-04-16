#!/bin/bash
#SBATCH --job-name=uvm_design_batch
#SBATCH --output=logs/job_%A_%a.out
#SBATCH --error=logs/job_%A_%a.err
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --array=0-29

LLM=${LLM:-"llama3.3:70b"}
ITER=${ITER:-1}
DEBUG=${DEBUG:-0}

DESIGNS=("adder_8bit" "adder_16bit" "adder_32bit" "multi_8bit" "multi_16bit" "sub_64bit" "div_16bit" "comparator_4bit" "accu" "fixed_point_add" "fsm" "sequence_detector" "JC_counter" "ring_counter" "up_down_counter" "asyn_fifo" "RAM" "ROM" "LFSR" "barrel_shifter" "clk_gen" "alu" "freq_div" "calendar" "traffic_light" "parallel2serial" "serial2parallel" "edge_detect" "width_8to16" "synchronizer")
DESIGN=${DESIGNS[$SLURM_ARRAY_TASK_ID]}

CMD="bash scripts/execution_script.sh \"$LLM\" \"$DESIGN\" \"$ITER\""

if [ "$DEBUG" -eq 1 ]; then
  echo "[DEBUG] Would execute: $CMD"
else
  eval "$CMD"
fi
