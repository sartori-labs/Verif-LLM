class UVMSequencerGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports
        self.sequencer_code = self.init_class()
        self.sequencer_code += self.init_macros()
        self.sequencer_code += self.construct()
        self.sequencer_code += self.misc()
        self.sequencer_code += self.terminate_class()
        
        self.write_sequencer_file()
        # print(self.sequence_code)

    def init_class(self):
        init_code = f"class {self.module_name}_sequencer extends uvm_sequencer #({self.module_name}_trans);\n\n"
        return init_code

    def init_macros(self):
        macros_code = f"\t// Utility Marco\n"
        macros_code += f"\t`uvm_component_utils({self.module_name}_sequencer);\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_sequencer\", uvm_component parent);\n"
        constructor_code += f"\t\tsuper.new(name, parent);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def misc(self):
        misc_code = f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_sequencer_file(self):
        sequencer_filename = f"testbench/sequencer.sv"
        with open(sequencer_filename, 'w') as file:
            file.write(self.sequencer_code)