# Change My MAC

Change My MAC is a Python application that allows you to change the MAC address of a network interface on both Windows and macOS systems.

## Requirements

- Python 3.x
- tkinter (included by default with Python)
- [spoof-mac](https://github.com/feross/spoofmac) (for macOS only)

## Installation

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
## Usage

Run the main.py file:
```shell
   sudo python3 main.py
```
The "Change My MAC" graphical interface will appear.
Enter the network interface name in the "Network Interface" field.
To generate a random MAC address, click the "Generate Random MAC Address" button.
To change the MAC address of the network interface to the provided one, click the "Change MAC Address" button.
## Support

If you encounter any issues or have questions, please open an issue in the issue tracker of this repository.

## Contributions

This project was developed by [LeoArs06](https://github.com/LeoArs06) and [Natisfaction](https://github.com/Natisfaction). Contributions from the community are welcome! If you would like to contribute to this project, please open a pull request and describe the proposed changes.

## License

