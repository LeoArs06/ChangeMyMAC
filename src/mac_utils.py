import subprocess
import re
from tkinter import messagebox
import random
import netifaces

def get_adapter_list():
    interfaces = netifaces.interfaces()
    return interfaces

def change_mac_address(interface, mac_address):
    if not interface:
        messagebox.showerror("Error", "No interfaces provided")
        return
    
    if not interface:
        messagebox.showerror("Error", "Interface not found in dictionary")
        return
    
    # Dissociating Airport should not give ANY kind of error
    subprocess.run(["sudo", "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport", "-z"], capture_output=True, text=True)

    result = subprocess.run(["sudo", "ifconfig", interface, "ether", mac_address], capture_output=True, text=True)
    output = result.stdout

    if "SIOCAIFADDR" in output.upper():
        messagebox.showerror("Error", "Can't update current MAC Address")
        
    messagebox.showinfo("Success", "MAC Address updated succesfully")
    
    return 0


def generate_mac_address():
    random_mac = [random.randint(0x00, 0xff) for _ in range(6)]
    # First byte odd (no multicast)
    random_mac[0] = random_mac[0] - (random_mac[0] % 2)

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


def is_valid_interface(interface):
    result = subprocess.run(["ifconfig", interface], capture_output=True, text=True)
    return result.returncode == 0
