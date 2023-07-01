import tkinter as tk
from tkinter import messagebox
from mac_utils import *
import re
import platform
    
def create_gui():

    #Controllo del sistema operativo
    if platform.system() == "Windows":
        import windows_utils as utils
    elif platform.system() == "Darwin":
        import mac_utils as utils
    elif platform.system() == "Linux":
        import linux_utils as utils
    else:
        messagebox.showerror("Error", "Sistema operativo non supportato.")
        return
    
    #Creazione della finestra principale
    window = tk.Tk()
    window.title("Change My Mac")
    window.geometry("600x400")

    #Creazione dei widget
    title_label = tk.Label(window, text="Change My Mac", font=("Arial", 18, "bold"))
    title_label.pack(pady=20)

    interface_frame = tk.Frame(window)
    interface_frame.pack()

    interface_label = tk.Label(interface_frame, text="Interfaccia di rete:", font=("Arial", 12))
    interface_label.pack(side=tk.LEFT, padx=10)

    interface_entry = tk.Entry(interface_frame, font=("Arial", 12))
    interface_entry.pack(side=tk.LEFT)

    mac_address_frame = tk.Frame(window)
    mac_address_frame.pack(pady=10)

    mac_address_label = tk.Label(mac_address_frame, text="Indirizzo MAC:", font=("Arial", 12))
    mac_address_label.pack(side=tk.LEFT, padx=10)

    mac_address_entry = tk.Entry(mac_address_frame, font=("Arial", 12))
    mac_address_entry.pack(side=tk.LEFT)

    generate_mac_button = tk.Button(window, text="Genera indirizzo MAC casuale", font=("Arial", 12),
                               command=lambda: generate_mac_button_clicked(interface_entry, mac_address_entry, current_mac_value))
    generate_mac_button.pack(pady=10)

    change_mac_button = tk.Button(window, text="Cambia indirizzo MAC", font=("Arial", 12),
                                 command=lambda: change_mac_button_clicked(interface_entry, mac_address_entry))
    change_mac_button.pack()

    current_mac_value = tk.StringVar()
    current_mac_value.set("Indirizzo MAC attuale: Non disponibile")
    current_mac_entry = tk.Label(window, textvariable=current_mac_value, font=("Arial", 12))
    current_mac_entry.pack(pady=10)

    #Aggiorna l'indicatore del MAC attuale quando viene modificata l'interfaccia di rete
    interface_entry.bind("<FocusOut>", lambda e: update_current_mac(interface_entry, current_mac_value))

    #loop della gui
    window.mainloop()

def change_mac_button_clicked(interface_entry, mac_address_entry):
    interface = interface_entry.get()
    mac_address = mac_address_entry.get()

    if not is_valid_interface(interface):
        messagebox.showerror("Error", "Interfaccia di rete non valida.")
        return

    if re.match(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$', mac_address):
        change_mac_address(interface, mac_address)
    else:
        messagebox.showerror("Error", "L'indirizzo MAC fornito non è valido.")


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
            current_mac_value.set("Indirizzo MAC attuale: " + mac_address)
        else:
            current_mac_value.set("Indirizzo MAC attuale: Non disponibile")
    else:
        current_mac_value.set("Interfaccia non valida")
