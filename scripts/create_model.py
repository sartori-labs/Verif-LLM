# from ollama import Client

# client = Client()
# response = client.create(
#   model='gemma3-t2',
#   from_='gemma3:27b',
#   system='You are a professional Verification Engineer',
#   stream=False,
#   parameters={'num_thread': 8, 'temperature': 0.2}
# )
# print(response.status)

from ollama import Client

LLMS = [
    "deepseek-r1:70b", "qwq:32b", "gemma3:27b",
    "llama3.3:70b", "qwen2.5:32b", "mistral-small3.1", 
    "phi4:14b"
]
temperatures = [0.0, 0.1, 0.2, 0.3]

client = Client()

for llm in LLMS:
    base_name = llm.split(":")[0]  # Keep only part before colon
    for temp in temperatures:
        model_name = f"{base_name}-t{str(temp).replace('.', '')}"
        try:
            response = client.create(
                model=model_name,
                from_=llm,
                system="You are a professional Verification Engineer. You have to generate UVM/SystemVerilog code.",
                stream=False,
                parameters={
                    'num_thread': 8,
                    'temperature': temp
                }
            )
            print(f"[SUCCESS] Created: {model_name} from {llm} with T={temp} → Status: {response.status}")
        except Exception as e:
            print(f"[ERROR] Failed to create {model_name} from {llm} with T={temp}: {e}")
