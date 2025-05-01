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

def generate_launch_script(llm, iteration, local):
    
    # launch_lines = ["#!/bin/bash\n"]
    launch_lines = [f"# Iteration {iteration}"]

    output_files = [
        "transaction.sv", "sequence.sv", "driver.sv", "monitor.sv",
        "agent.sv", "scoreboard.sv", "environment.sv", "test.sv"
    ]
    
    for design in DESIGNS:
        job_name = f"{design}_{llm}_iter{iteration}"
        out_log = f"logs/{job_name}.out"
        err_log = f"logs/{job_name}.err"
        design_path = f"designs/{design}"
        tb_path = f"{design_path}/tb"

        # Build file existence check string
        file_check = " && ".join([f"test -f {tb_path}/{fname}" for fname in output_files])
        
        # TODO: #16 set +e is might fail, think of an alternate way to fix clean
        wrapped_cmd = (
            f"python3 scripts/uvmgen.py '{llm}' '{design}' '{iteration}' "
            f"&& ({file_check}) "
            f"&& echo 'iter:{iteration} [uvmgen] OK' >> {design_path}/{llm}_status.log "
            f"|| (echo 'iter:{iteration} [uvmgen] FAIL' >> {design_path}/{llm}_status.log && exit 1)"
            f" && cd {design_path} "
            f"&& set +e "  # don't exit on failure from here
            f"&& (make vcs && echo 'iter:{iteration} [vcs] OK' >> {llm}_status.log || echo 'iter:{iteration} [vcs] FAIL' >> {llm}_status.log) "
            f"&& (make sim && echo 'iter:{iteration} [sim] OK' >> {llm}_status.log || echo 'iter:{iteration} [sim] FAIL' >> {llm}_status.log) "
            f"&& (make coverage_report && make coverage_summary | tee -a {llm}_status.log && echo 'iter:{iteration} [coverage] OK' >> {llm}_status.log || echo 'iter:{iteration} [coverage] FAIL' >> {llm}_status.log) "
            f"&& make clean_all && echo 'iter:{iteration} [clean] OK' >> {llm}_status.log || echo 'iter:{iteration} [clean] FAIL' >> {llm}_status.log"
        )
        
        if local:
            cmd = f"( {wrapped_cmd} ) &"
        else:
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
        
    # Add synchronization checkpoint after each iteration
    if local:
        launch_lines.append("wait")
        launch_lines.append(f"echo \"All local jobs in iteration {iteration} completed.\"\n")
    else:
        launch_lines.append("while squeue -u $USER | grep -q ' R\\| PD'; do")
        launch_lines.append("    sleep 10")
        launch_lines.append("done\n")

    return "\n".join(launch_lines)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--llm', required=True, help='LLM to run')
    # parser.add_argument('--iter', type=int, required=True, help='Iteration number')
    parser.add_argument('--local', type=int, choices=[0, 1], default=0, help='0=use SLURM, 1=run locally')

    parser.add_argument('--mode', choices=['generate', 'benchmark'], default='generate', help='Execution mode')
    parser.add_argument('--debug', action='store_true', help='Print instead of writing')
    args = parser.parse_args()

    if args.llm not in LLMS:
        raise ValueError(f"Unknown LLM: {args.llm}")

    os.makedirs('logs', exist_ok=True)
    os.makedirs('scripts', exist_ok=True)
    
    iterations = [1] if args.mode == 'generate' else range(1, 16)

    all_scripts = ["#!/bin/bash\n"]
    for i in iterations:
        all_scripts.append(generate_launch_script(args.llm, i, args.local))

    final_script = "\n".join(all_scripts)

    if args.debug:
        print(final_script)
    else:
        path = 'scripts/jobfile.sh'
        with open(path, 'w') as f:
            f.write(final_script)
        os.chmod(path, 0o755)
        print(f"[INFO] Launch script written to {path} with commands")

if __name__ == '__main__':
    main()
