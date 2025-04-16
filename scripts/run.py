# scripts/run.py
import subprocess
import argparse

LLMS = [
    "deepseek-r1:70b", "qwq:32b", "gemma3:27b",
    "llama3.3:70b", "qwen2.5:32b", "mistral-small3.1"
]

def run_batch(llm, iteration, debug=False):
    env_vars = f"--export=LLM={llm},ITER={iteration}"
    if debug:
        env_vars += ",DEBUG=1"

    cmd = ["sbatch", env_vars, "scripts/scheduler_script.slurm"]

    if debug:
        print("[DEBUG MODE] Would run:", " ".join(cmd))
    else:
        subprocess.run(cmd)

def run_all(debug=False):
    for llm in LLMS:
        for iteration in range(1, 16):
            run_batch(llm, iteration, debug)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Launch Verif-LLM jobs")
    parser.add_argument("--llm", type=str, help="Target LLM model")
    parser.add_argument("--iter", type=int, help="Iteration index")
    parser.add_argument("--all", action="store_true", help="Run all (LLM × Iter)")
    parser.add_argument("--debug", action="store_true", help="Print commands only")

    args = parser.parse_args()

    if args.all:
        run_all(debug=args.debug)
    elif args.llm and args.iter:
        run_batch(args.llm, args.iter, debug=args.debug)
    else:
        print("❌ Usage: --llm <LLM> --iter <N> or --all")
