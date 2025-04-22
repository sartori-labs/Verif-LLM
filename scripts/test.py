import ollama

# model_name = 'gemma3-t0:latest'
# model_detail = ollama.show(model_name)
# modelfile_content = model_detail['modelfile']

# with open('mymodel.modelfile', 'w') as f:
#     f.write(modelfile_content)
    
with open('mymodel.modelfile', 'r') as f:
    model_file = f.read()
    
response = ollama.create(model='gemma3-t0', modelfile=model_file)
print(response)  