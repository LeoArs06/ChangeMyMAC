import tkinter as tk
from tkinter import messagebox
import re
import platform

if platform.system() == "Windows":
    from win_utils import *

elif platform.system() == "Darwin":
    from mac_utils import *

elif platform.system() == "Linux":
    from linux_utils import *

else:
    messagebox.showerror("Error","OS not supported")
    exit()
    
def create_gui():
    #Creazione della finestra principale
    window = tk.Tk()
    window.title("Change My Mac")
    window.geometry("400x300")

    #Creazione dei widget
    title_label = tk.Label(window, text="Change My Mac", font=("Arial", 18, "bold"))
    title_label.pack(pady=20)

    interface_frame = tk.Frame(window)
    interface_frame.pack()

    interface_label = tk.Label(interface_frame, text="Network interface:", font=("Arial", 12))
    interface_label.pack(side=tk.LEFT, padx=10)

    interface_entry = tk.Entry(interface_frame, font=("Arial", 12))
    interface_entry.pack(side=tk.LEFT)

    mac_address_frame = tk.Frame(window)
    mac_address_frame.pack(pady=10)

    mac_address_label = tk.Label(mac_address_frame, text="MAC Address:     ", font=("Arial", 12))
    mac_address_label.pack(side=tk.LEFT, padx=10)

    mac_address_entry = tk.Entry(mac_address_frame, font=("Arial", 12))
    mac_address_entry.pack(side=tk.LEFT)

    generate_mac_button = tk.Button(window, text="      Random MAC Address     ", font=("Arial", 12), command=lambda: generate_mac_button_clicked(interface_entry, mac_address_entry, current_mac_value))
    generate_mac_button.pack(pady=10)

    change_mac_button = tk.Button(window, text="       Update MAC Address      ", font=("Arial", 12), command=lambda: change_mac_button_clicked(interface_entry, mac_address_entry, current_mac_value))
    change_mac_button.pack()

    current_mac_value = tk.StringVar()
    current_mac_value.set("[INFO] No information provided")
    current_mac_entry = tk.Label(window, textvariable=current_mac_value, font=("Arial", 12))
    current_mac_entry.pack(pady=10)

    #Aggiorna l'indicatore del MAC attuale quando viene modificata l'interfaccia di rete
    interface_entry.bind("<FocusOut>", lambda e: update_current_mac(interface_entry, current_mac_value))

    #loop della gui
    window.mainloop()

def change_mac_button_clicked(interface_entry, mac_address_entry, current_mac_value):
    interface = interface_entry.get()
    mac_address = mac_address_entry.get()

    if not is_valid_interface(interface):
        messagebox.showerror("Error", "Bad interface")
        return

    if re.match(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$', mac_address):
        if change_mac_address(interface, mac_address) == 0:
            current_mac_value.set("[OK] MAC Address updated successfully")
        else:
            current_mac_value.set("[ERROR] Can't update current MAC Address")
    else:
        messagebox.showerror("Error", "Bad MAC Address")


def generate_mac_button_clicked(interface_entry, mac_address_entry, current_mac_value):
    interface = interface_entry.get()
    random_mac_address = generate_mac_address()
    mac_address_entry.delete(0, tk.END)
    mac_address_entry.insert(0, random_mac_address)
    update_current_mac(interface_entry, current_mac_value)


def update_current_mac(interface_entry, current_mac_value):
    interface = interface_entry.get()

    if is_valid_interface(interface):
        mac_address = get_mac_address(interface)
        if mac_address:
            current_mac_value.set("[INFO] Actual MAC Address: " + mac_address)
        else:
            current_mac_value.set("[WARN] Actual MAC Address: not found")
    else:
        current_mac_value.set("[ERROR] Invalid interface")
