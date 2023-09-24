# Change My MAC

## Python version requirements
- Know how to find all the informations needed such as the interface name (of course)
- Python 3.x
- Tkinter Python module (usually included by default with Python)

- **ifconfig** (Linux only, should be preinstalled in non minimal installations)
- **powershell** command line (for Windows only)
- **sudo** access for macOS and Linux, or **administrator** access for Windows

## Prerequisites

### MacOS only
No individual steps required! Jump to the General ones!

### Linux only
Install ifconfig if not installed:
   ```shell
   sudo apt install net-tools
   ```

### Windows only
Install the psutil module:
   ```shell
   pip3 install psutil
   ```

### General steps
Install tkinter if not installed:
   ```shell
   pip3 install tkinter
   ```

Install netifaces module:
   ```shell
   pip3 install netifaces
   ```

Clone this repository:
   ```shell
   git clone https://github.com/LeoArs06/ChangeMyMAC.git
   ```

Navigate to the project directory:
   ```shell
   cd src
   ```

Launch the ChangeMyMac.py file (with administrator or sudo access):
   ```shell
   sudo python3 -u main.py
   ```

## Usage
After executing the program, the "Change My MAC" graphical interface will appear.
Select the network interface from the "Network Interface" dropdown menu, and then you're ready to perform some operations:

- **generating a random MAC address**, click the "Random MAC Address" button.
- **changing the MAC address** of the network interface to the provided one, click the "Update MAC Address" button.

## Binaries
If you don't want to use the Python version, we are developing some binaries. Just change the branch to see more details...

## Contributions
This project was developed by me [LeoArs06](https://github.com/LeoArs06) and [Natisfaction](https://github.com/Natisfaction), a cool friend of mine. 

## Licence
This repository is maintained under the MIT Licence.
