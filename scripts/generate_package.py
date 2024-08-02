class PackageGenerator:
    def __init__(self, module_name):
        self.module_name = module_name

        self.package_code = self.init_package()
        self.package_code += self.imports()
        self.package_code += self.add_includes()
        self.package_code += self.terminate_package()
        
        self.write_package_file()

    def init_package(self):
        package_code = f"package {self.module_name}_pkg;\n\n"
        return package_code

    def imports(self):
        imports_code = "\timport uvm_pkg::*;\n\n"
        return imports_code
    
    def add_includes(self):
        package_code = f"\t`include \"{self.module_name}_classes/transaction.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/sequencer.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/sequence.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/scoreboard.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/driver.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/monitor.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/agent.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/environment.sv\"\n"
        package_code += f"\t`include \"{self.module_name}_classes/test.sv\"\n\n"


        return package_code

    def terminate_package(self):
        package_code = f"endpackage : {self.module_name}_pkg"
        return package_code

    def write_package_file(self):
        package_filename = f"{self.module_name}_pkg.sv"
        with open(package_filename, 'w') as file:
            file.write(self.package_code)