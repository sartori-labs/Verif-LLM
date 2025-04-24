import argparse
import os

# deepseek - R1 - 70b 
# qwq - 32b
# gemma3 - 27b
# llama3 - 70b
# qwen25 - 32b
# mistral - small3.1 - 24b
# phi4 - 14b
LLMS = [
    "deepseek", "qwq", "gemma3",
    "llama3", "qwen25", "mistral", 
    "phi4"
]

# DESIGNS to Consider = [
#     "adder_8bit", "adder_16bit", "adder_32bit", "multi_8bit", "multi_16bit",
#     "sub_64bit", "div_16bit", "comparator_4bit", "accu", "fixed_point_add",
#     "fsm", "sequence_detector", "JC_counter", "ring_counter", "up_down_counter",
#     "asyn_fifo", "RAM", "ROM", "LFSR", "barrel_shifter", "clk_gen", "alu",
#     "freq_div", "calendar", "traffic_light", "parallel2serial", "serial2parallel",
#     "edge_detect", "width_8to16", "synchronizer"
# ]

# Paths
base_dir = os.path.dirname(os.path.dirname(__file__))
DESIGNS = os.listdir(os.path.join(base_dir, "designs"))

print(DESIGNS)

def generate_launch_script(llm, iteration):
    launch_lines = ["#!/bin/bash\n"]

    output_files = [
        "transaction.sv", "sequence.sv", "driver.sv", "monitor.sv",
        "agent.sv", "scoreboard.sv", "environment.sv", "test.sv"
    ]
    # TODO: #15 Add checkpoint after each iteration
    # while squeue -u $USER | grep -q ' R\| PD'; do
    #   sleep 10
    # done
    for design in DESIGNS:
        job_name = f"{design}_{llm}_iter{iteration}"
        out_log = f"logs/{job_name}.out"
        err_log = f"logs/{job_name}.err"
        design_path = f"designs/{design}"
        tb_path = f"{design_path}/tb"

        # Build file existence check string
        file_check = " && ".join([f"test -f {tb_path}/{fname}" for fname in output_files])
        
        wrapped_cmd = (
            f"python3 scripts/uvmgen.py '{llm}' '{design}' '{iteration}' "
            f"&& ({file_check}) "
            f"&& echo 'iter:{iteration} [uvmgen] OK' >> {design_path}/{llm}_status.log "
            f"|| (echo 'iter:{iteration} [uvmgen] FAIL' >> {design_path}/{llm}_status.log && exit 1)"
            f" && cd {design_path}"
            f" && (make vcs && echo 'iter:{iteration} [vcs] OK' >> {llm}_status.log || (echo 'iter:{iteration} [vcs] FAIL' >> {llm}_status.log && exit 1))"
            f" && (make sim && echo 'iter:{iteration} [sim] OK' >> {llm}_status.log || (echo 'iter:{iteration} [sim] FAIL' >> {llm}_status.log && exit 1))"
            f" && (make coverage_report coverage_summary && echo 'iter:{iteration} [coverage] OK' >> {llm}_status.log || (echo 'iter:{iteration} [coverage] FAIL' >> {llm}_status.log && exit 1))"
            f" && (make clean && echo 'iter:{iteration} [clean] OK' >> {llm}_status.log || (echo 'iter:{iteration} [clean] FAIL' >> {llm}_status.log && exit 1))"
            f" && (rm -rf && echo 'iter:{iteration} [cleanup] OK' >> {llm}_status.log || echo 'iter:{iteration} [cleanup] FAIL' >> {llm}_status.log)"
        )

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
            f"--wrap=\"{wrapped_cmd}\""
        )

        launch_lines.append(cmd)

    return "\n".join(launch_lines)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--llm', required=True, help='LLM to run')
    parser.add_argument('--iter', type=int, required=True, help='Iteration number')
    
    # TODO: #8 Add parameter - mode = benchmark, generate
    parser.add_argument('--debug', action='store_true', help='Print instead of writing')
    args = parser.parse_args()

    if args.llm not in LLMS:
        raise ValueError(f"Unknown LLM: {args.llm}")

    os.makedirs('logs', exist_ok=True)
    os.makedirs('scripts', exist_ok=True)
    
    # TODO: #9 put this in a loop if mode is benchmark, do it once if generate
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
