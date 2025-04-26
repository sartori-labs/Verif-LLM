import argparse
from ollama import Client
import subprocess

def list_available_models():
    try:
        result = subprocess.run(["ollama", "list"], check=True, text=True, capture_output=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print("Error running 'ollama list':")
        print(e.stderr)

# Command-line argument parser
parser = argparse.ArgumentParser(description="Create a model with Ollama.")
parser.add_argument("--model", type=str, help="Target model name (e.g., gemma3-t2)")
parser.add_argument("--from_", type=str, help="Source model (e.g., gemma3:27b)")
parser.add_argument("--temperature", type=float, default=0.2, help="Sampling temperature (default: 0.2)")
parser.add_argument("--list-models", action="store_true", help="List available models for --from_")

args = parser.parse_args()

# Handle model listing request
if args.list_models:
    list_available_models()
    exit(0)

# Validate required arguments
if not args.model or not args.from_:
    parser.error("the following arguments are required: --model, --from_")

# Command-line argument parser
parser = argparse.ArgumentParser(description="Create a model with Ollama.")
parser.add_argument("--model", type=str, help="Target model name (e.g., gemma3-t2)")
parser.add_argument("--from_", type=str, help="Source model (e.g., gemma3:27b)")
parser.add_argument("--temperature", type=float, default=0.2, help="Sampling temperature (default: 0.2)")
parser.add_argument("--list-models", action="store_true", help="List available models for --from_")

args = parser.parse_args()

# Handle model listing request
if args.list_models:
    list_available_models()
    exit(0)

# Validate required arguments
if not args.model or not args.from_:
    parser.error("the following arguments are required: --model, --from_")
    
# Initialize Ollama client and create model
client = Client()
response = client.create(
  model=args.model,
  from_=args.from_,
  system='You are a professional Verification Engineer. You have to generate UVM/SystemVerilog code only.',
  stream=False,
  parameters={'num_thread': 8, 'temperature': args.temperature}
)

print(response.status)


# from ollama import Client

# LLMS = [
#     "deepseek-r1:70b", "qwq:32b", "gemma3:27b",
#     "llama3.3:70b", "qwen2.5:32b", "mistral-small3.1", 
#     "phi4:14b"
# ]
# temperatures = [0.0, 0.1, 0.2, 0.3]

# client = Client()

# for llm in LLMS:
#     base_name = llm.split(":")[0]  # Keep only part before colon
#     for temp in temperatures:
#         model_name = f"{base_name}-t{str(temp).replace('.', '')}"
#         try:
#             response = client.create(
#                 model=model_name,
#                 from_=llm,
#                 system="You are a professional Verification Engineer. You have to generate UVM/SystemVerilog code.",
#                 stream=False,
#                 parameters={
#                     'num_thread': 8,
#                     'temperature': temp
#                 }
#             )
#             print(f"[SUCCESS] Created: {model_name} from {llm} with T={temp} → Status: {response.status}")
#         except Exception as e:
#             print(f"[ERROR] Failed to create {model_name} from {llm} with T={temp}: {e}")
