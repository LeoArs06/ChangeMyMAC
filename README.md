# Change My MAC

Change My MAC is a Python application that allows you to change the MAC address of a network interface on Windows, macOS and Linux based systems.

## Credits

This software uses the [spoof-mac](https://github.com/feross/spoofmac) package, developed by [feross](https://github.com/feross). Original spoof-mac code can be found in his GitHub repository.

## Requirements

- Know how to find all the informations needed such as the interface name (of course)
- Python 3.x
- tkinter (included by default with Python)

- [spoof-mac](https://github.com/feross/spoofmac) (for macOS and Linux)
- [netsh](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh) (for Windows only)
- **sudo** access for macOS and Linux, or **administrator** access for Windows

## Usage

### Using python
Clone the repository:
   ```shell
   git clone https://github.com/LeoArs06/change-my-mac.git
   ```
Navigate to the project directory:
   ```shell
   cd change-my-mac
   ```
Optional: Create and activate a virtual environment:
   ```shell
   python -m venv venv
   source venv/bin/activate
   ```
Install the dependencies:
   ```shell
   pip install -r requirements.txt
   ```
Install spoof-mac via Homebrew (for macOS only):
   ```shell
   brew install spoof-mac
   ```

Run the main.py file:
```shell
   sudo python3 main.py
```

### Using binaries
In the [releases](https://github.com/LeoArs06/Change-My-MAC/releases) tab download the version you need.
REMEMBER: the OS and the architecture MUST match your computer ones.

### Both
After doing the steps described above, the "Change My MAC" graphical interface will appear.
Enter the network interface name in the "Network Interface" field.
To generate a random MAC address, click the "Generate Random MAC Address" button.
To change the MAC address of the network interface to the provided one, click the "Change MAC Address" button.
To make a backup of the original MAC Adress, click the "Backup MAC Adress" button.
To restore the backup, click the "Restore MAC Adress" button.

## Contributions

This project was developed by [LeoArs06](https://github.com/LeoArs06) and [Natisfaction](https://github.com/Natisfaction). 
