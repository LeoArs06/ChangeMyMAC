# Change My MAC

Change My MAC is a Python application that allows you to change the MAC address of a network interface on Windows, macOS and Linux based systems, in few and really easy steps.

## Credits

This software uses the [spoof-mac](https://github.com/feross/spoofmac) package, developed by [feross](https://github.com/feross). Original spoof-mac code can be found in his GitHub repository.

## Requirements

- Know how to find all the informations needed such as the interface name (of course)
- Python 3.x
- tkinter Python module (usually included by default with Python)

- [spoof-mac](https://github.com/feross/spoofmac) (for macOS)
- [netsh](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh) (for Windows only)
- **sudo** access for macOS and Linux, or **administrator** access for Windows

## Installation

Clone the repository:
   ```shell
   git clone https://github.com/LeoArs06/change-my-mac.git
   ```
Navigate to the project directory:
   ```shell
   cd change-my-mac
   ```
Install spoof-mac via Homebrew (for macOS only):
   ```shell
   brew install spoof-mac
   ```
Install tkinker if not installed:
   ```shell
   pip3 install tkinker
   ```
Launch the ChangeMyMac.py file (with administrator or sudo access):
   ```shell
   python3 -u ChangeMyMac.py
   ```

### Using binaries
In the [releases](https://github.com/LeoArs06/Change-My-MAC/releases) tab download the version you need.
REMEMBER: the OS and the architecture MUST match your computer ones.

## Usage
After executing the program, the "Change My MAC" graphical interface will appear.
Enter the network interface name in the "Network Interface" field, and then you're ready to perform some operations:
- generate a random MAC address, click the "Generate Random MAC Address" button.
- change the MAC address of the network interface to the provided one, click the "Change MAC Address" button.
- make a backup of the original MAC Adress, click the "Backup MAC Adress" button.
- restore the backup, click the "Restore MAC Adress" button.

## Contributions

This project was developed by [LeoArs06](https://github.com/LeoArs06) and [Natisfaction](https://github.com/Natisfaction). 
