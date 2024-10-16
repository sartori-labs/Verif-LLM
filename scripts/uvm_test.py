class UVMTestGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports

        self.test_code = self.init_class()
        self.test_code += self.init_macros()
        self.test_code += self.construct()
        self.test_code += self.declarations()
        self.test_code += self.build_phase()
        self.test_code += self.end_of_elaboration_phase()
        self.test_code += self.start_of_simulation_phase()
        self.test_code += self.run_phase()

        self.test_code += self.misc()
        self.test_code += self.terminate_class()
        
        self.write_test_file()
        # print(self.test_code)

    def init_class(self):
        init_code = f"class {self.module_name}_test extends uvm_test;\n\n"
        return init_code

    def init_macros(self):
        macros_code = f"\t// Utility Marco\n"
        macros_code += f"\t`uvm_component_utils({self.module_name}_test);\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_test\", uvm_component parent = null);\n"
        constructor_code += f"\t\tsuper.new(name, parent);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def declarations(self):
        declaration_code = f"\t// Declare the environment(s) here\n\n\n"
        declaration_code += f"\t// Declare the sequence(s) here\n\n\n"
    
        return declaration_code

    def build_phase(self):
        build_phase_code = f"\t// Build Phase - construct the testbench components\n"
        build_phase_code += f"\tvirtual function void build_phase (uvm_phase phase);\n"
        build_phase_code += f"\t\tsuper.build_phase(phase);\n"
        build_phase_code += f"\t\t// Instantiate different environments here\n\n\n"
        build_phase_code += f"\t\t// Instantiate the sequence(s) here\n\n\n"
        build_phase_code += f"\tendfunction : build_phase\n\n"

        return build_phase_code
    
    def end_of_elaboration_phase(self):
        end_of_elaboration_phase_code = f"\t// By this phase, the environment is all set up so print the topology for debug\n"
        end_of_elaboration_phase_code += f"\tvirtual function void end_of_elaboration_phase (uvm_phase phase);\n"
        end_of_elaboration_phase_code += f"\t\tuvm_top.print_topology();\n"
        end_of_elaboration_phase_code += f"\tendfunction : end_of_elaboration_phase\n\n"

        return end_of_elaboration_phase_code
    
    def start_of_simulation_phase(self):
        start_of_simulation_phase_code = f"\tvirtual function void start_of_simulation_phase (uvm_phase phase);\n"
        start_of_simulation_phase_code += f"\t\tsuper.start_of_simulation_phase(phase);\n"
        start_of_simulation_phase_code += f"\tendfunction : start_of_simulation_phase\n\n"

        return start_of_simulation_phase_code

    def run_phase(self):
        run_phase_code = f"\t// Run Phase - main piece of the test code\n"
        run_phase_code += f"\tvirtual task run_phase (uvm_phase phase);\n"
        run_phase_code += f"\t\tsuper.run_phase(phase);\n\n"
        run_phase_code += f"\t\t// Raise objection - else this test will not consume simulation time\n"
        run_phase_code += f"\t\tphase.raise_objection(this, \"Starting Test\");\n\n"
        
        run_phase_code += "\t\t// Start the sequence on the sequencer\n\n\n"

        run_phase_code += "\t\t// Drop objection - else this test will not finish\n"
        run_phase_code += "\t\tphase.drop_objection(this, \"Ending Test\");\n\n"
        run_phase_code += f"\tendtask : run_phase\n\n"

        return run_phase_code

    def misc(self):
        misc_code = f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_test_file(self):
        test_filename = f"testbench/test.sv"
        with open(test_filename, 'w') as file:
            file.write(self.test_code)