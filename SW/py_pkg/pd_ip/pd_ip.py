from periphery import MMIO
import warnings

class pd_ip():
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="", mmio_init=True
    ):
        self.ip_dict = ip_dict
        self.ip_dict["BASE"] = int(ip_dict["BASE"])
        self.ip_dict["SPAN"] = int(ip_dict["SPAN"])
        self.ip_dict["END"] = int(ip_dict["END"])
        # This should map to entire platform designer qsys mmio address space
        if(mmio_init):
            self.mmio = MMIO(ifc_base+self.ip_dict["BASE"], self.ip_dict["SPAN"], mmio_path)
        self.ifc_base = ifc_base

    def read_csr(self, offset, size_bytes):
        address = offset
        if((address + size_bytes + self.ip_dict["BASE"]) <= (self.ip_dict["BASE"] + self.ip_dict["SPAN"])):
            if size_bytes == 4:
                return self.mmio.read32(address)
            elif size_bytes == 2:
                return self.mmio.read16(address)
            elif size_bytes == 1:
                return self.mmio.read8(address)
            else:
                return self.mmio.read(address, size_bytes)
        else:
            warnings.warn(f"Warning: Read @ address {address} not in IP address space! Read was not successful!")
            return -1

    def write_csr(self, offset, size_bytes, data):
        address = offset
        if((address + size_bytes + self.ip_dict["BASE"]) <= (self.ip_dict["BASE"] + self.ip_dict["SPAN"])):
            if size_bytes == 4:
                self.mmio.write32(address, data)
            elif size_bytes == 2:
                self.mmio.write16(address, data)
            elif size_bytes == 1:
                self.mmio.write8(address, data)
            else:
                self.mmio.write(address, data)
        else:
            warnings.warn(f"Warning: Write @ address {address} not in IP address space! Read was not successful!")
            return -1

    def copy_mmio_ifc(self, obj_in):
        try:
            obj_in.ip_dict["BASE"] = self.ip_dict["BASE"]
            obj_in.ip_dict["SPAN"] = self.ip_dict["SPAN"]
            obj_in.ip_dict["END"] = self.ip_dict["END"]
            obj_in.mmio = self.mmio
            obj_in.ifc_base = self.ifc_base
            return 0
        except:
            warnings.warn(f"Warning: Copy error, input object does not have matching attributes!")
            return -1
        
    def print_ip_info(self):
        print(f"######## Begin {self.ip_dict['COMPONENT_NAME']} IP instance data ########")
        for key in self.ip_dict.keys():
            print(f"\t{key} : {self.ip_dict[key]}")
        print(f"######### End {self.ip_dict['COMPONENT_NAME']} IP instance data #########\n")
