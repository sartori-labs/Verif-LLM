import os
import re
import sys
import ollama

def generate_uvm_modules(llm_model, design_name, iteration):
    # Paths
    # home_directory = os.path.expanduser("~")
    base_dir = os.path.dirname(os.path.dirname(__file__))
    input_dir = os.path.join(base_dir, "prompts")
    design_dir = os.path.join(base_dir, "designs", design_name, "dut")
    output_dir = os.path.join(base_dir, "designs", design_name, "TB")
    result_dir = os.path.join(base_dir, "designs", design_name, "results")

    print(base_dir)
    print(design_dir)
    print(input_dir)
    print(output_dir)
    print(result_dir)

    os.makedirs(output_dir, exist_ok=True)
    os.makedirs(result_dir, exist_ok=True)

    # Clear old TB files
    for f in os.listdir(output_dir):
        os.remove(os.path.join(output_dir, f))

    # Copy static files
    design_path = os.path.join(base_dir, "designs", design_name)
    for fname in os.listdir(design_path):
        if fname.endswith(".sv") or fname.endswith(".svh") or fname == "Makefile":
            os.system(f"cp {os.path.join(design_path, fname)} {output_dir}/")
    os.system(f"cp {os.path.join(design_path, 'dut')}/*.v {output_dir}/")

    design_file = os.path.join(input_dir, "design.txt")
    with open(design_file, "r") as f:
        design_desc = f.read()

    input_files = [
        "transaction.txt", "sequence.txt", "driver.txt", "monitor.txt",
        "agent.txt", "scoreboard.txt", "environment.txt", "test.txt"
    ]
    output_files = [
        "transaction.sv", "sequence.sv", "driver.sv", "monitor.sv",
        "agent.sv", "scoreboard.sv", "environment.sv", "test.sv"
    ]

    for in_file, out_file in zip(input_files, output_files):
        with open(os.path.join(input_dir, in_file), "r") as f:
            prompt = design_desc + f.read()

        response = ollama.generate(model=llm_model, prompt=prompt).response
        matches = re.findall(r"```(.*?)```", response, re.DOTALL)

        if matches:
            lines = matches[0].strip().split("\n")
            if len(lines) > 1:
                extracted = "\n".join(lines[1:])
                with open(os.path.join(output_dir, out_file), "w") as f:
                    f.write(extracted)
                print(f"[INFO] {out_file} written.")
            else:
                print(f"[WARN] {out_file} content empty.")
        else:
            print(f"[ERROR] No content found in response for {in_file}")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python3 uvmgen.py <LLM> <DESIGN> <ITER>")
        sys.exit(1)

    LLM = sys.argv[1]
    DESIGN = sys.argv[2]
    ITER = sys.argv[3]
    

    generate_uvm_modules(LLM, DESIGN, ITER)
