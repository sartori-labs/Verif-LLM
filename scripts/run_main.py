#!/usr/bin/env python3

import sys
import os
import warnings
import re
import argparse
import yaml

from generate_interface import InterfaceGenerator
from uvm_transaction import UVMTransactionGenerator
from uvm_sequence import UVMSequemceGenerator
from uvm_sequencer import UVMSequencerGenerator
from uvm_driver import UVMDriverGenerator
from uvm_monitor import UVMMonitorGenerator
from uvm_agent import UVMAgentGenerator
from uvm_scoreboard import UVMScoreboardGenerator
from uvm_environment import UVMEnvironmentGenerator
from generate_package import PackageGenerator
from uvm_test import UVMTestGenerator

warnings.filterwarnings("ignore", category=SyntaxWarning)

rel_lib_path = os.environ["VERDI_HOME"] + "/share/NPI/python"

sys.path.append(os.path.abspath(rel_lib_path))
from pynpi import lang
from pynpi import netlist
from pynpi import npisys

def extract_instances(file_path):
    extracted_instances = []
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.split(',')
            if len(parts) > 2:
                extracted_instances.append(parts[1].strip())
    return extracted_instances

def read_yaml_config(file_path):
    with open(file_path, 'r') as file:
        config = yaml.safe_load(file)
    return config

def parse_log_file(file_path):
    log_map = {}

    # Read the log file
    with open(file_path, 'r') as file:
        for line in file:
            # Match the key-value pair
            match = re.match(r'(\w+): \[(.*)\]', line.strip())
            if match:
                key = match.group(1)
                value = match.group(2)

                # Extract PinHdl and npiNlPort values
                ports = re.findall(r"PinHdl\('npiNlPort', '([^']+)'\)", value)
                
                # Extract terms after the last period in each string
                port_list = []
                for port in ports:
                    signal = port.split('.')[-1]
                    type = netlist.get_port(port).direction(True)
                    if(type == 1):
                        port_type = 'input'
                    elif(type == 2):
                        port_type = 'ouput'
                    else:
                        port_type = 'inout'
                    split = signal.find('[')
                    if(split > 0):
                        width = signal[split:]
                        signal = signal[:split]
                    else: 
                        width = None

                    port_list.append({
                        'type': port_type,
                        'name': signal,
                        'bus': width
                    })

                log_map[key] = port_list

    return log_map

# main
if __name__ == '__main__':

    # initialize NPI and load design example.v
    if not npisys.init(sys.argv):
        print("Error: Fail to initialize NPI.")
        assert 0
    if not npisys.load_design(sys.argv):
        print("Error: Fail to load design.")
        assert 0

    instance_file = "inst_info.log"
    fp = open(instance_file, 'w')

    # get top instances
    top_inst_list = lang.get_top_inst_list()
    for inst_hdl in top_inst_list:
        # print("Top instance: "+inst_hdl.full_name())
        # dump hier tree
        hdl_list = lang.hier_tree_trv_inst(inst_hdl.full_name())
        lang.dump_hdl_vec_info(hdl_list, fp)
        
    fp.close()
    module_map = {}

    for instance in extract_instances(instance_file):
        # print(instance)
        def_name = netlist.get_inst(instance).def_name()
        # print(f'{def_name}')
        
        if def_name not in module_map:
            port_list = netlist.get_inst(instance).port_list()
            module_map[def_name] = port_list

    # Write the ports info to a file to flatten the structure
    ports_file = "ports_info.log"
    with open(ports_file, 'w') as f:
        for key, value in module_map.items():
            f.write(f'{key}: {value}\n')

    all_ports_info = parse_log_file(ports_file)

    # for key, value in all_ports_info.items():
    #     print(f'{key}: {value}\n')

    res = npisys.end()

    os.remove(instance_file)
    os.remove(ports_file)

    # Define the directory name
    # directory_name = "tb_classes"

    # Check if the directory exists
    # if not os.path.exists(directory_name):
        # Create the directory
        # os.mkdir(directory_name)
        # print(f"Directory '{directory_name}' created.")
    # else:
    #     print(f"Directory '{directory_name}' already exists.")

    required_modules = []

    yaml_config = "config.yaml"
    
    with open(yaml_config, 'r') as file:
        config = yaml.safe_load(file)

    sections = config.keys()  # Automatically get the top-level keys
    
    for section in sections:
        # print(f"\nModule: {section}")
        if(config[section]['required'] == True):
            required_modules.append(config[section]['name'])

    # print(required_modules)
    
    # Process the aggregated ports information
    for module_name, ports in all_ports_info.items():
        # print(module_name)
        # print(ports)
        # print("\n")
        if module_name in required_modules:
            directory_name = "testbench"
            if not os.path.exists(directory_name):
                # Create the directory
                os.mkdir(directory_name)

            InterfaceGenerator(module_name, ports)
            UVMTransactionGenerator(module_name, ports)
            UVMSequemceGenerator(module_name, ports)
            UVMSequencerGenerator(module_name, ports)
            UVMDriverGenerator(module_name, ports)
            UVMMonitorGenerator(module_name, ports)
            UVMAgentGenerator(module_name, ports)
            UVMScoreboardGenerator(module_name, ports)
            UVMEnvironmentGenerator(module_name, ports)
            UVMTestGenerator(module_name, ports)
            PackageGenerator(module_name)
        else:
            print(f"Module '{module_name}' skipped.")
