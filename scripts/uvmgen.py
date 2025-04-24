import os
import re
import sys
import time
import subprocess
import ollama
from concurrent.futures import ThreadPoolExecutor, as_completed

os.environ['CUDA_VISIBLE_DEVICES'] = '0'  # Use the first GPU

def start_ollama_server_and_wait(timeout=30, interval=1):
    """Start ollama serve if not already running and wait until ready"""
    try:
        ollama.list()
        print("[INFO] Ollama is already running.")
        return
    except Exception:
        print("[INFO] Starting Ollama server...")
        subprocess.Popen(["ollama", "serve"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # Poll until it's ready
    for i in range(timeout):
        try:
            ollama.list()
            print("[INFO] Ollama server is now ready.")
            return
        except Exception:
            print(f"[INFO] Waiting for Ollama... ({i + 1}/{timeout})")
            time.sleep(interval)

    raise RuntimeError("Ollama server did not start in time. Please run `ollama serve` manually and retry.")

def generate_single_component(llm_model, llm_in, out_file, output_dir):
    try:
        llm_out = ollama.generate(model=llm_model, prompt=llm_in, options={'temperature': 0}).response
        matches = re.findall(r"```(.*?)```", llm_out, re.DOTALL)

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
            print(f"[ERROR] No code block found for {out_file}")
    except Exception as e:
        print(f"[ERROR] Exception while generating {out_file}: {e}")

def generate_uvm_modules(llm_model, design_name, iteration):
    start_ollama_server_and_wait()

    # Paths
    base_dir = os.path.dirname(os.path.dirname(__file__))
    # input_dir = os.path.join(base_dir, "prompts")
    design_dir = os.path.join(base_dir, "designs", design_name, "dut")
    output_dir = os.path.join(base_dir, "designs", design_name, "tb")
    result_dir = os.path.join(base_dir, "designs", design_name, "results")

    os.makedirs(output_dir, exist_ok=True)
    os.makedirs(result_dir, exist_ok=True)

    # Clear old TB files
    for f in os.listdir(output_dir):
        os.remove(os.path.join(output_dir, f))

    design_file = os.path.join(design_dir, "design.txt")
    with open(design_file, "r") as f:
        design_desc = f.read()

    implementation_file = os.path.join(design_dir, "implementation.txt")
    with open(implementation_file, "r") as f:
        implementation = f.read()

    # TODO: #10 put these prompts in a file and read it once
    # TODO: #11 modify the prompts to get better responses
    transaction_prompt = "Required:\nTransaction class - " + design_name + "_trans - Write a UVM sequence item to represent a transaction. All inputs should be randomized except clk and rst_n. Outputs are just bits.\n\nGive code for transaction.sv only"
    sequence_prompt = "Required:\nSequence class - " + design_name + "_sequence #(" + design_name + "_trans) - Write a UVM sequence that generates multiple randomized transactions in a loop for high functional coverage.\n\nGive code for sequence.sv only"
    driver_prompt = "Required:\nDriver classs - " + design_name + "_driver - Write a UVM driver that takes transactions from the sequencer, assign values to inputs through the virtual interface. Use anlysis port to send transaction to scoreboard.\n\nGive code for driver.sv only"
    monitor_prompt = "Required:\nMonitor class - " + design_name + "_monitor - Write a UVM monitor that connects to the virtual interface. The monitor should sample the values of I/O during each transaction, package them into a UVM transaction object, and forward the data to an analysis port for scoreboard verification.\n\nGive code for monitor.sv only"
    agent_prompt = "Required:\nAgent class - " + design_name + "_agent - write a UVM agent. it should include a sequencer, driver, monitor and the virtual interface. \n\nGive code for agent.sv only"
    scoreboard_prompt = "Required:\nScoreboard class - " + design_name + "_scoreboard - Write a UVM scoreboard that should receive transactions from the monitor through an analysis port, compute the expected result, and compare it to the output from the interface. Report mismatches.\n\n" + implementation + "\n\nGive code for scoreboard.sv only"
    environment_prompt = "Required:\nEnvironment class - " + design_name + "_environment - Write a UVM environment class that includes the agent and the scoreboard. Connect the monitor to the environment. Connect the environment to the scoreboard.\n\nGive code for environment.sv only"
    test_prompt = "Required:\nTest class - " + design_name + "_test - Write a UVM test class, declare environment and sequence, build_phase - instantiate environment and sequence and run_phase - phase.raise_objection, start_sequencer, phase.drop_objection\n\nGive code for test.sv only"
    
    prompts = [transaction_prompt, sequence_prompt, driver_prompt, monitor_prompt,
               agent_prompt, scoreboard_prompt, environment_prompt, test_prompt
    ]
    
    output_files = [
        "transaction.sv", "sequence.sv", "driver.sv", "monitor.sv",
        "agent.sv", "scoreboard.sv", "environment.sv", "test.sv"
    ]

    llm_inputs = [design_desc + "\n\n" + prompt for prompt in prompts]
    
    # Run in parallel
    with ThreadPoolExecutor(max_workers=len(llm_inputs)) as executor:
        futures = [
            executor.submit(generate_single_component, llm_model, llm_in, out_file, output_dir)
            for llm_in, out_file in zip(llm_inputs, output_files)
        ]

        for future in as_completed(futures):
            future.result()

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python3 uvmgen.py <LLM> <DESIGN> <ITER>")
        sys.exit(1)

    LLM = sys.argv[1]
    DESIGN = sys.argv[2]
    ITER = sys.argv[3]
    
    generate_uvm_modules(LLM, DESIGN, ITER)