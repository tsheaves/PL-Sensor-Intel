import sys
# setting path
sys.path.append('../../pd_ip')
# importing
from pd_ip.pd_ip import pd_ip
from Crypto.Cipher import AES

class sec_works_aes(pd_ip):
    def __init__(
        self, ip_dict={}, ifc_base=0x0000, mmio_path="", 
        mmio_init = True, key=[], reset_pio=None
    ):
        super().__init__(ip_dict, ifc_base, mmio_path, mmio_init)
        self.key = key
        self.reset_pio = reset_pio
    
    def reset(self):
        self.reset_pio.write_csr(0,4,1)
        self.reset_pio.write_csr(0,4,0)
    
    def __word_combine__(self, arr, n, len_wrd):
        long_word = 0
        for idx in range(n):
            long_word |= (arr[idx] << (idx*len_wrd))
        return long_word

    def aes_decrypt_ecb_128_prime(self, ctxt):
        # Required registers
        ADDR_CTRL      = 0x08 << 2
        ADDR_CONFIG    = 0x0A << 2
        ADDR_KEY0      = 0x10 << 2
        ADDR_BLOCK0    = 0x20 << 2

        # Load key
        for idx, key_word in enumerate(self.key):
            self.write_csr(ADDR_KEY0 + ((idx) << 2), 4, key_word)

        # Key expansion
        self.write_csr(ADDR_CONFIG, 4, 0x00)
        self.write_csr(ADDR_CTRL, 4, 0x01)

        # Load ctxt
        for idx, ctxt_word in enumerate(ctxt[::-1]):
            self.write_csr(ADDR_BLOCK0 + ((idx) << 2), 4, ctxt_word)

    def aes_decrypt_ecb_128_run(self):
        # Required registers
        ADDR_CTRL      = 0x08 << 2
        # Start
        self.write_csr(ADDR_CTRL, 4, 0x02)

    def aes_decrypt_ecb_128_check(self, ctxt):
        # Required registers
        ADDR_STATUS    = 0x09 << 2
        ADDR_RESULT0   = 0x30 << 2

        while((self.read_csr(ADDR_STATUS, 4) & 0x3) != 0x3):
            continue

        # Get results
        ptxt = []
        for idx in range(4):
            ptxt_word = self.read_csr(ADDR_RESULT0 + ((idx)<<2), 4)
            ptxt.append(ptxt_word)
        ptxt = ptxt[::-1]
        ptxt_rslt =  self.__word_combine__(ptxt, 4, 32).to_bytes(16, 'big')
        key_check =  self.__word_combine__(self.key[::-1], 4, 32).to_bytes(16, 'big')
        ctxt_check = self.__word_combine__(ctxt, 4, 32).to_bytes(16, 'big')
        decipher = AES.new(key_check, AES.MODE_ECB)
        ptxt_check = decipher.decrypt(ctxt_check)

        # Return check
        return (ptxt_check != ptxt_rslt)
