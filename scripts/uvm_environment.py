class UVMEnvironmentGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports

        self.environment_code = self.init_class()
        self.environment_code += self.init_macros()
        self.environment_code += self.construct()
        self.environment_code += self.declarations()
        self.environment_code += self.build_phase()
        self.environment_code += self.connect_phase()

        self.environment_code += self.misc()
        self.environment_code += self.terminate_class()
        
        self.write_environment_file()
        # print(self.environment_code)

    def init_class(self):
        init_code = f"class {self.module_name}_env extends uvm_env;\n\n"
        return init_code

    def init_macros(self):
        macros_code = f"\t// Utility Marco\n"
        macros_code += f"\t`uvm_component_utils({self.module_name}_env);\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_env\", uvm_component parent = null);\n"
        constructor_code += f"\t\tsuper.new(name, parent);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def declarations(self):
        declaration_code = f"\t// Declare the agent(s) and scoreboard(s) here\n\n\n"
        declaration_code += f"\t// Declare the analysis port(s) here\n\n\n"
    
        return declaration_code

    def build_phase(self):
        build_phase_code = f"\t// Build Phase - construct the testbench components\n"
        build_phase_code += f"\tvirtual function void build_phase (uvm_phase phase);\n"
        build_phase_code += f"\t\tsuper.build_phase(phase);\n\n"
        build_phase_code += f"\t\t// Instantiate different agent(s) and scoreboard(s) here\n\n\n"
        build_phase_code += f"\t\t// Instantiate the analysis export port\n\n\n"
        build_phase_code += f"\tendfunction : build_phase\n\n"

        return build_phase_code
    
    def connect_phase(self):
        connect_phase_code = f"\t// Connect Phase - connect TLM ports of the components\n"
        connect_phase_code += f"\tvirtual function void connect_phase (uvm_phase phase);\n"
        connect_phase_code += f"\t\tsuper.connect_phase(phase);\n\n"
        connect_phase_code += f"\t\t// Connect the agent's monitor analysis port to the environment's analysis export\n\n"
        connect_phase_code += f"\t\t// Connect the environment's analysis export to the scoreboard's analysis export\n\n\n"
    
        connect_phase_code += f"\tendfunction : connect_phase\n\n"

        return connect_phase_code

    def misc(self):
        misc_code = f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_environment_file(self):
        environment_filename = f"{self.module_name}_classes/environment.sv"
        with open(environment_filename, 'w') as file:
            file.write(self.environment_code)