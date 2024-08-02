class UVMScoreboardGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports

        self.scoreboard_code = self.init_class()
        self.scoreboard_code += self.init_macros()
        self.scoreboard_code += self.construct()
        self.scoreboard_code += self.declarations()
        self.scoreboard_code += self.build_phase()

        self.scoreboard_code += self.misc()
        self.scoreboard_code += self.terminate_class()
        
        self.write_scoreboard_file()
        # print(self.scoreboard_code)

    def init_class(self):
        init_code = f"class {self.module_name}_scoreboard extends uvm_scoreboard;\n\n"
        return init_code

    def init_macros(self):
        macros_code = f"\t// Utility Marco\n"
        macros_code += f"\t`uvm_component_utils({self.module_name}_scoreboard);\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_scoreboard\", uvm_component parent = null);\n"
        constructor_code += f"\t\tsuper.new(name, parent);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def declarations(self):
        declaration_code = f"\t// Declare the port(s) here\n\n\n"
    
        return declaration_code

    def build_phase(self):
        build_phase_code = f"\t// Build Phase - construct the testbench components\n"
        build_phase_code += f"\tvirtual function void build_phase (uvm_phase phase);\n"
        build_phase_code += f"\t\tsuper.build_phase(phase);\n"
        build_phase_code += f"\t\t// Initialize the port(s)\n\n\n"
        build_phase_code += f"\tendfunction : build_phase\n\n"

        return build_phase_code

    def misc(self):
        misc_code = f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_scoreboard_file(self):
        scoreboard_filename = f"{self.module_name}_classes/scoreboard.sv"
        with open(scoreboard_filename, 'w') as file:
            file.write(self.scoreboard_code)