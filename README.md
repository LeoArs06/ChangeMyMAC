# Change My MAC

Change My MAC is a Python application that allows you to change the MAC address of a network interface on macOS and Linux based systems, in few and really easy steps.
Windows support very soon

## Credits

This software uses the [spoof-mac](https://github.com/feross/spoofmac) package for the macOS version, developed by [feross](https://github.com/feross). Original spoof-mac code can be found in his linked GitHub repository.

## Requirements

- Know how to find all the informations needed such as the interface name (of course)
- Python 3.x
- tkinter Python module (usually included by default with Python)

- **[spoof-mac](https://github.com/feross/spoofmac)** (for macOS)
- **[netsh](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh)** (for Windows only)
- **ifconfig** (Linux only, should be preinstalled in non minimal installations)

- **sudo** access for macOS and Linux, or **administrator** access for Windows

## Installation

Install spoof-mac via Homebrew (for macOS only):
   ```shell
   brew install spoof-mac
   ```
Install ifconfig if not installed (Linux only):
   ```shell
   sudo apt install net-tools
   ```
Install tkinker if not installed:
   ```shell
   pip3 install tkinker
   ```

Clone the repository:
   ```shell
   git clone https://github.com/LeoArs06/change-my-mac.git
   ```
Navigate to the project directory:
   ```shell
   cd change-my-mac
   ```
Launch the ChangeMyMac.py file (with administrator or sudo access):
   ```shell
   python3 -u ChangeMyMac.py
   ```

### Using binaries
If you're not confident in using the python script you can download and use the binaries. 
In the [releases](https://github.com/LeoArs06/Change-My-MAC/releases) tab download the version you need.

REMEMBER: the OS and the architecture MUST match your computer ones, otherwise the program won't work.

## Usage
After executing the program, the "Change My MAC" graphical interface will appear.
Enter the network interface name in the "Network Interface" field, and then you're ready to perform some operations:

- **generate a random MAC address**, click the "Generate Random MAC Address" button.
- **change the MAC address** of the network interface to the provided one, click the "Change MAC Address" button.
- **create a backup of the original MAC Adress**, click the "Backup MAC Adress" button.
- **restore the backup**, click the "Restore MAC Adress" button.

## Contributions

This project was developed by [LeoArs06](https://github.com/LeoArs06) and [Natisfaction](https://github.com/Natisfaction). 

## Licence

This repository is maintained under the MIT Licence.
