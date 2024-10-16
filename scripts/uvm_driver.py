class UVMDriverGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports

        self.driver_code = self.init_class()
        self.driver_code += self.init_macros()
        self.driver_code += self.construct()
        self.driver_code += self.declarations()
        self.driver_code += self.build_phase()
        self.driver_code += self.run_phase()

        self.driver_code += self.misc()
        self.driver_code += self.terminate_class()
        
        self.write_driver_file()
        # print(self.driver_code)

    def init_class(self):
        init_code = f"class {self.module_name}_driver extends uvm_driver #({self.module_name}_trans);\n\n"
        return init_code

    def init_macros(self):
        macros_code = f"\t// Utility Marco\n"
        macros_code += f"\t`uvm_component_utils({self.module_name}_driver);\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_driver\", uvm_component parent = null);\n"
        constructor_code += f"\t\tsuper.new(name, parent);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def declarations(self):
        declaration_code = f"\t// Declare the virtual interface handle(s) here\n\n\n"
        declaration_code += f"\t// Analysis port to broadcast input values to the Scoreboard\n\n\n"
        declaration_code += f"\t// Placeholder for the transaction information\n\n\n"
        return declaration_code

    def build_phase(self):
        build_phase_code = f"\t// Build Phase - construct the testbench components\n"
        build_phase_code += f"\tvirtual function void build_phase (uvm_phase phase);\n"
        build_phase_code += f"\t\tsuper.build_phase(phase);\n"
        build_phase_code += f"\t\t// Get the virtual interface (if any) here\n\n\n"
        build_phase_code += f"\t\t// Initialize the Analysis Port\n\n\n"
        build_phase_code += f"\tendfunction : build_phase\n\n"

        return build_phase_code
    
    def run_phase(self):
        run_phase_code = f"\t// Run Phase - main piece of the driver code which decides how it has to translate\n\t// transaction level objects into pin wiggles at the DUT interface\n"
        run_phase_code += f"\tvirtual task run_phase (uvm_phase phase);\n"
        run_phase_code += f"\t\tsuper.run_phase(phase);\n\n\n"
    
        run_phase_code += f"\tendtask : run_phase\n\n"

        return run_phase_code

    def misc(self):
        misc_code = f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_driver_file(self):
        driver_filename = f"testbench/driver.sv"
        with open(driver_filename, 'w') as file:
            file.write(self.driver_code)