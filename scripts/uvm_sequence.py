class UVMSequemceGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports
        self.sequence_code = self.init_class()
        self.sequence_code += self.init_macros()
        self.sequence_code += self.construct()
        self.sequence_code += self.declarations()
        self.sequence_code += self.pre_body()
        self.sequence_code += self.body()
        self.sequence_code += self.post_body()

        self.sequence_code += self.misc()
        self.sequence_code += self.terminate_class()
        
        self.write_sequence_file()
        # print(self.sequence_code)

    def init_class(self):
        init_code = f"class {self.module_name}_sequence extends uvm_sequence #({self.module_name}_trans);\n\n"
        return init_code

    def init_macros(self):
        macros_code = f"\t// Utility Marco\n"
        macros_code += f"\t`uvm_obect_utils({self.module_name}_sequence);\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_sequence\");\n"
        constructor_code += f"\t\tsuper.new(name);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def declarations(self):
        declaration_code = f"\t// Declare the transaction(s)\n\n\n"

        return declaration_code

    def pre_body(self):
        pre_body_code = f"\t// Called before the body() task\n"
        pre_body_code += f"\tvirtual task pre_body();\n"
        pre_body_code += f"\t\t// Optional code can be placed here in pre-body()\n\n"
        pre_body_code += f"\t\tif(starting_phase != null)\n"
        pre_body_code += f"\t\t\tstarting_phase.raise_objection(this);\n"
        pre_body_code += f"\tendtask : pre_body\n\n"

        return pre_body_code
    
    def body(self):
        body_code = f"\t// Main task of the sequence\n"
        body_code += f"\tvirtual task body();\n"
        body_code += f"\t\tstart_item(trans);\n\n\n"

        body_code += f"\t\tfinish_item(trans);\n"
        body_code += f"\tendtask : boody\n\n"

        return body_code
    
    def post_body(self):
        post_body_code = f"\t// Called after the body() task\n"
        post_body_code += f"\tvirtual task post_body();\n"
        post_body_code += f"\t\t// Optional code can be placed here in post-body()\n\n"
        post_body_code += f"\t\tif(starting_phase != null)\n"
        post_body_code += f"\t\t\tstarting_phase.drop_objection(this);\n"
        post_body_code += f"\tendtask : post_body\n\n"

        return post_body_code

    def misc(self):
        misc_code = f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_sequence_file(self):
        sequence_filename = f"{self.module_name}_classes/sequence.sv"
        with open(sequence_filename, 'w') as file:
            file.write(self.sequence_code)