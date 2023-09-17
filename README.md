# Change My MAC

## macOS
This readme refers to the macOS program. Change branch to see other supported OSes

## Requirements
- Know how to find all the informations needed such as the interface name (of course)
- **sudo** access (password)
- macOS Ventura or higher

## Installation
Grab the binary from the releases section, and download the .app file.

## Usage
After executing the program, ChangeMyMAC will create a tray icon. Click it to access the main menu.

![Interface](https://github.com/LeoArs06/ChangeMyMAC/blob/macOS/src/README/ChangeMyMAC.png)

From here you just have to select the interface you want to change the MAC, and then type in a VALID MAC address.
You have two buttons:
- **Random MAC**, generates a random MAC for you.
- **Update MAC**, actually changes the MAC address.

## FAQ

#### Why is the program not starting???
There are many things that can block the program from starting up, the main issue could be the macOS version, which has to be Ventura (13) or higher.

#### Why is the program not changing some interface's MAC Address???
Some macOS interfaces are protected and cannot be "managed" normally, and thus, you can't change their MAC address.

#### How do I quit the program???
Just click on the wheel on the top right, then click the exit button.

#### I don't have macOS Ventura or higher, how can I use the program???
You can just grab the Python one, from the main branch!

## Contributions
This program has been "readapted" from our main python program (see the main brach), and [Natisfaction](https://github.com/Natisfaction) reworked the UI in swift.

## Licence
This repository is maintained under the MIT Licence.
