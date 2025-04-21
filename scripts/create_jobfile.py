import argparse
import os

LLMS = [
    "deepseek-r1:70b", "qwq:32b", "gemma3:27b",
    "llama3.3:70b", "qwen2.5:32b", "mistral-small3.1", 
    "phi4:14b"
]

DESIGNS = [
    "adder_8bit", "adder_16bit", "adder_32bit", "multi_8bit", "multi_16bit",
    "sub_64bit", "div_16bit", "comparator_4bit", "accu", "fixed_point_add",
    "fsm", "sequence_detector", "JC_counter", "ring_counter", "up_down_counter",
    "asyn_fifo", "RAM", "ROM", "LFSR", "barrel_shifter", "clk_gen", "alu",
    "freq_div", "calendar", "traffic_light", "parallel2serial", "serial2parallel",
    "edge_detect", "width_8to16", "synchronizer"
]

def generate_launch_script(llm, iteration):
    launch_lines = ["#!/bin/bash\n"]

    for design in DESIGNS:
        job_name = f"{design}_{llm.replace(':', '_')}_iter{iteration}"
        out_log = f"logs/{job_name}.out"
        err_log = f"logs/{job_name}.err"

        cmd = (
            f"sbatch "
            f"--job-name={job_name} "
            f"--output={out_log} "
            f"--error={err_log} "
            f"--partition=msigpu "
            f"--gres=gpu:a100:1 "
            f"--cpus-per-task=4 "
            f"--mem=16G "
            f"--time=00:30:00 "
            f"--wrap=\"python3 scripts/uvmgen.py '{llm}' '{design}' '{iteration}'\""
        )
        launch_lines.append(cmd)

    return "\n".join(launch_lines)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--llm', required=True, help='LLM to run')
    parser.add_argument('--iter', type=int, required=True, help='Iteration number')
    parser.add_argument('--debug', action='store_true', help='Print instead of writing')
    args = parser.parse_args()

    if args.llm not in LLMS:
        raise ValueError(f"Unknown LLM: {args.llm}")

    os.makedirs('logs', exist_ok=True)
    os.makedirs('scripts', exist_ok=True)

    script_content = generate_launch_script(args.llm, args.iter)

    if args.debug:
        print(script_content)
    else:
        path = 'scripts/jobfile.sh'
        with open(path, 'w') as f:
            f.write(script_content)
        os.chmod(path, 0o755)
        print(f"[INFO] Launch script written to {path} with 30 sbatch commands")

if __name__ == '__main__':
    main()
