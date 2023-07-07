import subprocess
import re
from tkinter import messagebox
import random
import psutil

def get_adapter_list():
    output = subprocess.check_output(["powershell", "Get-NetAdapter | Select-Object -ExpandProperty Name"]).decode("utf-8")
    interfaces = re.findall(r"(\w+-\w+|\w+)", output)
    return interfaces

def change_mac_address(interface, mac_address):
    if not interface:
        messagebox.showerror("Error", "No interfaces provided")
        return
    
    mac_address = mac_address.replace(":","-")
    result = subprocess.run(["powershell", "-Command", "Set-NetAdapter", "-Name", interface, "-MacAddress", mac_address, "-Confirm:$false"], capture_output=True)
    subprocess.run(["netsh", "interface", "set", "interface", interface, "enable"],text=True)

    if not result.returncode == 0:
        messagebox.showerror("Error", "Can't update current MAC Address")
        return 1
    else:
        messagebox.showinfo("Success", "MAC Address updated succesfully")
    
    return 0

def generate_mac_address():
    random_mac = [random.randint(0x00, 0xff) for _ in range(6)]
    #Primo byte deve essere pari (no multicast)
    random_mac[0] = random_mac[0] - (random_mac[0] % 2)

    random_mac_address = ":".join([f"{x:02x}" for x in random_mac])
    return random_mac_address

def get_mac_address(interface):
    for interfaces in psutil.net_if_addrs():
        # Check if the interface name matches the desired interface
        if interfaces == interface:
            # Get the MAC address for the interface
            mac_address = psutil.net_if_addrs()[interfaces][0].address
            mac_address = mac_address.replace("-",":")
            return mac_address

    return None

def is_valid_interface(interface):
    result = subprocess.run(["powershell", "-Command", "Get-NetAdapter", interface], capture_output=True)
    return result.returncode == 0
