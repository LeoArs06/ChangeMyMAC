import subprocess
import re
import sys
import random
import tkinter as tk
from tkinter import messagebox


def change_mac_address(interface, mac_address):
    if not interface:
        current_mac_value.set("[ERROR] Specificare un'interfaccia di rete...")
        return
    
    #netsh interface set interface "AdapterName" admin=enable


    result1 = subprocess.run(["netsh", "interface", "set", "interface", interface, "admin=disable"], capture_output=True, text=True)
    result2 = subprocess.run(["netsh", "interface", "set", "interface", interface, "newmac=", mac_address], capture_output=True, text=True)
    result3 = subprocess.run(["netsh", "interface", "set", "interface", interface, "admin=enable"], capture_output=True, text=True)
    
    output1 = result1.stdout
    output2 = result2.stdout
    output3 = result3.stdout

    if "error" in output1.lower() or "error" in output2.lower() or "error" in output3.lower():
        current_mac_value.set("[ERROR] Errore durante il cambio dell'indirizzo MAC...")
    else:
        current_mac_value.set("[OK] Indirizzo MAC aggiornato con successo!!!")


def generate_mac_address():
    random_mac = [random.randint(0x00, 0xff) for _ in range(6)]
    random_mac_address = ":".join([f"{x:02x}" for x in random_mac])
    return random_mac_address


def get_mac_address(interface):
    result = subprocess.run(["ipconfig /all", ], capture_output=True, text=True)
    output = result.stdout

    mac_isvalid = re.search(r'ether\s+([0-9A-Fa-f:]{17})', output)

    if mac_isvalid:
        mac_actual = mac_isvalid.group(1)
        return mac_actual
    return None


def is_valid_interface(interface):
    result = subprocess.run(["ipconfig /all"], capture_output=True, text=True)
    return result.returncode == 0


def change_mac_button_clicked():
    interface = interface_entry.get()
    mac_address = mac_address_entry.get()

    if not is_valid_interface(interface):
        current_mac_value.set("[ERROR] Interfaccia di rete non è valida...")
        return

    if re.match(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$', mac_address):
        change_mac_address(interface, mac_address)
    else:
        current_mac_value.set("[ERROR] L'indirizzo MAC fornito non è valido...")


def generate_mac_button_clicked():
    interface = interface_entry.get()
    random_mac_address = generate_mac_address()
    mac_address_entry.delete(0, tk.END)
    mac_address_entry.insert(0, random_mac_address)
    update_current_mac()

#Aggiunto questo \/ \/ \/

def restore_default_mac_button_clicked():
    interface = interface_entry.get()
    try:
        with open("mac_interface_"+interface_entry.get()+".txt","r") as file:
            mac_address_entry.delete(0, tk.END)
            mac_address_entry.insert(0, file.read())

            file.close()
            current_mac_value.set("[OK] Backup del MAC originale trovato!!!")

    except FileNotFoundError:
        if not interface:
            current_mac_value.set("[ERROR] Nessuna interfaccia inserita...")
        else:
            current_mac_value.set("[ERROR] Nessun backup trovato per l'interfaccia "+interface)

def backup_default_mac_button_clicked():
    with open("mac_interface_"+interface_entry.get()+".txt","w") as file:
        file.write(get_mac_address(interface_entry.get()))
        file.close()

#Aggiunto questo /\ /\ /\

def update_current_mac():
    interface = interface_entry.get()

    if is_valid_interface(interface):
        mac_address = get_mac_address(interface)
        if mac_address:
            current_mac_value.set("[OK] Indirizzo MAC attuale: " + mac_address)
        else:
            current_mac_value.set("[INFO] Indirizzo MAC attuale: non disponibile...")
    else:
        current_mac_value.set("[ERROR] Interfaccia non valida...")

#Backup dell'indirizzo mac corrente

#Creazione della finestra principale
window = tk.Tk()
window.title("Change My Mac")
window.geometry("400x300")
window.iconbitmap("icon.ico")

#Creazione dei widget
title_label = tk.Label(window, text="Change My Mac", font=("Arial", 18, "bold"))
title_label.pack(pady=20)

interface_frame = tk.Frame(window)
interface_frame.pack()

interface_label = tk.Label(interface_frame, text="Interfaccia di rete:   ", font=("Arial", 12))
interface_label.pack(side=tk.LEFT, padx=10)

interface_entry = tk.Entry(interface_frame, font=("Arial", 12))
interface_entry.pack(side=tk.LEFT)

mac_address_frame = tk.Frame(window)
mac_address_frame.pack(pady=10)

mac_address_label = tk.Label(mac_address_frame, text="Indirizzo MAC:        ", font=("Arial", 12))
mac_address_label.pack(side=tk.LEFT, padx=10)

mac_address_entry = tk.Entry(mac_address_frame, font=("Arial", 12))
mac_address_entry.pack(side=tk.LEFT)

generate_mac_button = tk.Button(window, text=" Genera indirizzo MAC casuale", font=("Arial", 12), command=generate_mac_button_clicked)
generate_mac_button.pack()

change_mac_button = tk.Button(window, text="      Aggiorna indirizzo MAC      ", font=("Arial", 12), command=change_mac_button_clicked)
change_mac_button.pack(pady=(0,10))

backup_mac_button = tk.Button(window, text="         Salva indirizzo MAC        ", font=("Arial", 12), command=backup_default_mac_button_clicked)
backup_mac_button.pack()

restore_mac_button = tk.Button(window, text="      Ripristina indirizzo MAC     ", font=("Arial", 12), command=restore_default_mac_button_clicked)
restore_mac_button.pack()

current_mac_value = tk.StringVar()
current_mac_value.set("[INFO] Indirizzo MAC attuale: Non disponibile")
current_mac_entry = tk.Label(window, textvariable=current_mac_value, font=("Arial", 12))
current_mac_entry.pack(pady=10)

#Aggiorna l'indicatore del MAC attuale quando viene modificata l'interfaccia di rete
interface_entry.bind("<FocusOut>", lambda e: update_current_mac())

#Avvio del loop di eventi della GUI
window.mainloop()
