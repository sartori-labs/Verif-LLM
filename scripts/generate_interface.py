class InterfaceGenerator:
    def __init__(self, module_name, ports):
        self.module_name = module_name
        self.ports = ports

        self.interface_code = self.init_interface()
        self.interface_code += self.init_signals()
        self.interface_code += self.terminate_interface()
        
        self.write_interface_file()

    def init_interface(self):
        interface_code = "interface {}_if();\n".format(self.module_name)
        return interface_code

    def init_signals(self):
        interface_code = ""
        for port in self.ports:
            port_type = port['type']
            port_name = port['name']
            bus = port['bus']

            if bus:
                interface_code += f"\tlogic {bus} {port_name};\n"
            else:
                interface_code += f"\tlogic {port_name};\n"

        return interface_code

    def terminate_interface(self):
        interface_code = "endinterface"
        return interface_code

    def write_interface_file(self):
        interface_filename = f"{self.module_name}_if.sv"
        with open(interface_filename, 'w') as file:
            file.write(self.interface_code)