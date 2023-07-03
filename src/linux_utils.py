import subprocess
import re
from tkinter import messagebox
import random

def change_mac_address(interface, mac_address):
    if not interface:
        messagebox.showerror("Error", "Specificare un'interfaccia di rete.")
        return

    subprocess.run(["sudo","ifconfig",interface,"down"])
    result = subprocess.run(["sudo", "ifconfig", interface, "hw", "ether", mac_address], capture_output=True, text=True)
    subprocess.run(["sudo","ifconfig",interface,"up"])
    
    output = result.stdout

    if "error" in output.lower():
        messagebox.showerror("Error", "Si è verificato un errore durante il cambio dell'indirizzo MAC.")
    else:
        messagebox.showinfo("Success", "L'indirizzo MAC è stato cambiato correttamente.")

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


def is_valid_interface(interface):
    result = subprocess.run(["ifconfig", interface], capture_output=True, text=True)
    return result.returncode == 0