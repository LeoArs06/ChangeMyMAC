# Change My MAC

Change My MAC is a Python application that allows you to change the MAC address of a network interface on macOS and Linux based systems, in few and really easy steps.

## Credits

This software uses the [spoof-mac](https://github.com/feross/spoofmac) package for the macOS version, developed by [feross](https://github.com/feross). Original spoof-mac code can be found in his linked GitHub repository.

## Requirements

- Know how to find all the informations needed such as the interface name (of course)
- Python 3.x
- tkinter Python module (usually included by default with Python)

- **[spoof-mac](https://github.com/feross/spoofmac)** (for macOS)
- **ifconfig** (Linux only, should be preinstalled in non minimal installations)
- **powershell** command line (for Windows only)

- **sudo** access for macOS and Linux, or **administrator** access for Windows

## Installation

### MacOS only

Install spoof-mac via Homebrew (macOS only):
   ```shell
   brew install spoof-mac
   ```

### Linux only

Install ifconfig if not installed (Linux only):
   ```shell
   sudo apt install net-tools
   ```

### Windows only
Install the psutil module (Windows only)
   ```shell
   pip3 install psutil
   ```

### General steps

Install tkinker if not installed:
   ```shell
   pip3 install tkinker
   ```

Install netifaces:
   ```shell
   pip3 install netifaces
   ```

Clone the repository:
   ```shell
   git clone https://github.com/LeoArs06/change-my-mac.git
   ```

Navigate to the project directory:
   ```shell
   cd src
   ```

Launch the ChangeMyMac.py file (with administrator or sudo access):
   ```shell
   python3 -u main.py
   ```

## Usage

After executing the program, the "Change My MAC" graphical interface will appear.
Enter the network interface name in the "Network Interface" field, and then you're ready to perform some operations:

- **generate a random MAC address**, click the "Random MAC Address" button.
- **change the MAC address** of the network interface to the provided one, click the "Update MAC Address" button.

## Contributions

This project was developed by me [LeoArs06](https://github.com/LeoArs06) and [Natisfaction](https://github.com/Natisfaction), a cool friend of mine. 

## Licence

This repository is maintained under the MIT Licence.
