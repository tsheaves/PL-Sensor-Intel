from periphery import MMIO
import warnings

class pd_ip():
    def __init__(
        self, ip_dict={}, mmio=None
    ):
        self.ip_dict = ip_dict
        self.ip_dict["BASE"] = int(ip_dict["BASE"])
        self.ip_dict["SPAN"] = int(ip_dict["SPAN"])
        self.ip_dict["END"] = int(ip_dict["END"])
        # This should map to entire platform designer qsys mmio address space
        self.mmio = mmio

    def read_csr(self, offset, size_bytes):
        address = self.ip_dict["BASE"] + offset
        if((address + size_bytes) <= (self.ip_dict["BASE"] + self.ip_dict["SPAN"])):
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
        address = self.ip_dict["BASE"] + offset
        if((address + size_bytes) <= (self.ip_dict["BASE"] + self.ip_dict["SPAN"])):
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

    def print_ip_info(self):
        print(f"######## Begin {self.ip_dict['COMPONENT_NAME']} IP instance data ########")
        for key in self.ip_dict.keys():
            print(f"\t{key} : {self.ip_dict[key]}")
        print(f"######### End {self.ip_dict['COMPONENT_NAME']} IP instance data #########\n")
