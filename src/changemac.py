import subprocess
import re
import sys
import random

def change_mac_address(interface, mac_address):
    subprocess.run(["sudo", "spoof-mac", "set", mac_address, interface])

def generate_mac_address():
    random_mac = [random.randint(0x00, 0xff) for _ in range(6)]
    random_mac_address = ":".join([f"{x:02x}" for x in random_mac])
    return random_mac_address

def get_mac_address(interface):
    result = subprocess.run(["ifconfig", interface], capture_output=True, text=True)
    output = result.stdout

    mac_isvalid = re.search(r'ether\s+([0-9A-Fa-f:]{17})', output)

    if mac_isvalid:
        mac_actual = mac_isvalid.group(1)
        return mac_actual
    return None

if len(sys.argv) > 1:
    interface = sys.argv[1]

    if len(sys.argv) > 2:
        mac_address = sys.argv[2]
        if re.match(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$', mac_address):
            change_mac_address(interface, mac_address)
        else:
            print("L'indirizzo MAC fornito non è valido.")
    else:
        random_mac_address = generate_mac_address()
        print(f"Indirizzo MAC generato casualmente ({datetime.now()}): {random_mac_address}")
        change_mac_address(interface, random_mac_address)
else:
    print("Nessuna interfaccia di rete specificata")
