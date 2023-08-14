from dissect.cstruct import cstruct
import warnings
import importlib

class pd_system():

    def __init__(
        self, pd_system_name=None, header_files=[], sys_offset=0x0000
    ):
        self.pd_system_name=pd_system_name
        self.header_files=header_files
        self.sys_offset=sys_offset
        self.components = {}
        self.pd_ip_insts={}

    def initialize(self, debug=False):
        for header_file in self.header_files:
            print(f"Imported from {header_file}")
            self.__import_header__(header_file)
        if(debug):
            self.__print_components__()
        self.__components_to_inst_objs__()

    def __import_header__(self, header_file):
        # Convert sopcinfo header file to dictionary
        c=cstruct()
        lines = []
        with open(header_file, 'r') as hf:
            while True:
                line = hf.readline()
                if not line:
                    break
                if("#ifndef" in line):
                    hf.readline()
                elif("#endif" not in line):
                    lines.append(line)
        header_str = "\n".join(lines)
        c.load(header_str)
        header_dict = c.consts
        component_dict = {}
        for key_i in header_dict.keys():
            if("_COMPONENT_NAME" in key_i):
                component_key = header_dict[key_i]
                component_dict[component_key] = {}
                for key_j in header_dict.keys():
                    if(component_key.upper() in key_j):
                        component_attribute_key = key_j.split(component_key.upper()+"_")[1]
                        component_dict[component_key][component_attribute_key] = header_dict[key_j]
                        if("_COMPONENT_TYPE" in key_j):
                             component_dict[component_key]["COMPONENT_TYPE"]=header_dict[key_j]
        self.components.update(component_dict)

    def __print_components__(self):
        for keys_i in self.components.keys():
            print(f"COMPONENT_NAME: {keys_i}")
            for keys_j in self.components[keys_i].keys():
                print(f"\t{keys_j} : {self.components[keys_i][keys_j]}")

    # All Platform Designer instances in design should either reside in custom/quartus IP packages
    def __components_to_inst_objs__(self):
        for component_key in self.components.keys():
            component_dict = self.components[component_key]
            component_type = component_dict["COMPONENT_TYPE"]
            try:
                component_module = importlib.import_module(f"pd_ip.custom_ips.{component_type}")
                ComponentClass = getattr(component_module, component_type)
            except:
                component_module = importlib.import_module(f"pd_ip.quartus_ips.{component_type}")
                ComponentClass = getattr(component_module, component_type)
            component_obj = ComponentClass(component_dict)
            self.pd_ip_insts[component_key] = component_obj

