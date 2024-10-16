class UVMTransactionGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports
        self.trans_code = self.init_class()
        self.trans_code += self.init_signals()
        self.trans_code += self.init_macros()
        self.trans_code += self.construct()
        self.trans_code += self.misc()
        self.trans_code += self.terminate_class()
        
        self.write_trans_file()
        # print(self.trans_code)

    def init_class(self):
        init_code = f"class {self.module_name}_trans extends uvm_sequence_item;\n\n"
        return init_code

    def init_signals(self):
        signals_code = f"\t// Control and signals\n"
        for port in self.ports:
            port_type = port['type']
            port_name = port['name']
            bus = port['bus']

            if port_type == "input":
                if bus:
                    signals_code += f"\trand bit {bus} {port_name};\n"
                else:
                    signals_code += f"\trand bit {port_name};\n"
            else:
                if bus:
                    signals_code += f"\tbit {bus} {port_name};\n"
                else:
                    signals_code += f"\tbit {port_name};\n"
            
        signals_code += "\n"

        return signals_code

    def init_macros(self):
        macros_code = f"\t// Utility and Field Marcos\n"
        macros_code += f"\t`uvm_obect_utils({self.module_name}_trans)\n"
        for port in self.ports:
            port_type = port['type']
            port_name = port['name']
            bus = port['bus']

            if port_type == "input":
                macros_code += f"\t\t`uvm_field_int({port_name}, UVM_ALL_ON)\n" # Extend this for string type in the future. Refer https://www.chipverify.com/uvm/uvm-utility-field-macros

        macros_code += f"\t`uvm_object_utils_end\n\n"
        
        return macros_code

    def construct(self):
        constructor_code = f"\t// Constructor: This is the standard code for all components\n"
        constructor_code += f"\tfunction new (string name = \"{self.module_name}_trans\");\n"
        constructor_code += f"\t\tsuper.new(name);\n"
        constructor_code += f"\tendfunction : new\n\n"

        return constructor_code

    def misc(self):
        misc_code = f"\t// Add constraints here (if any)\n\n\n"
        misc_code += f"\t// Additional Functions go here\n\n\n"

        return misc_code

    def terminate_class(self):
        terminate_code = f"endclass"
        return terminate_code

    def write_trans_file(self):
        trans_filename = f"testbench/transaction.sv"
        with open(trans_filename, 'w') as file:
            file.write(self.trans_code)
