# Change My MAC

## macOS
This readme refers to the macOS program. Change branch to see other supported platforms.

## Disclaimer
As you can imagine, changing the MAC Address of interfaces is something usefull when you're doing ethical hacking, BUT can also be used to "bypass" some device restrictions into a network, or some other stuffs like that.

For those particular reasons, we must proclaim that this program was designed and solely meant for EDUCATIONAL PURPOSES. WE DO NOT ENCOURAGE THE PROGRAM USAGE FOR MALICIOUS PURPOSES, AND WE ARE NOT GOING TO BE RESPONSIBLE FOR ANY OF YOUR ACTIONS.

IF YOU'RE NOT 100% SURE IF WHATEVER YOU'RE DOING IS LEGAL, JUST DO NOT DO THAT!

## Requirements
- Know how to find all the informations needed such as the interface name (of course)
- **sudo** access (root password)
- **macOS Ventura** or higher

## Installation
Grab the binary from the releases section.

## Usage
After executing the program, ChangeMyMAC will create a tray icon. Click it to access the main menu.

![Interface](https://github.com/LeoArs06/ChangeMyMAC/blob/macOS/src/README/ChangeMyMAC.png)

From here you just have to select the interface you want to change the MAC, and then type in a **VALID** MAC address, or just hit the **Random MAC** button to create a random MAC Address for you.

Clicking the **Update MAC** button, will open a new window, asking you for the root password. After prompting in the password, two operations will be performed:

- The network will be dissociated from Airport
- The MAC Address will be changed

Then a success window should appear, reconnect to the network, and you're good to go!

## FAQ

#### Why is Change My MAC not starting???
There are many things that can block the program from starting up, the main issue could be the macOS version, which has to be Ventura (13) or higher.

#### Why is Change My MAC not changing some interface's MAC Address???
Some macOS interfaces are protected by the OS, and cannot be "managed" normally, and thus, you can't change their MAC address.

#### How do I quit Change My MAC???
Just click on the wheel on the top right, then click the exit button.

#### I don't have macOS Ventura or higher, how can I use Change My MAC???
You can just grab the Python program, from the main branch! After installing all the required modules should work fien!

#### I have an Intel mac, is that a problem???
Not at all! Change My MAC had been compiled for both Intel and Apple Silicon based macs (Universal). You don't need to worry for the architecture of your mac!

#### Why do you need the root password???
You can't change the MAC Address with normal user right, so a privileged operation is required.

#### Why is the app not sandboxed???
Due to the fact we need to execute some commands as sudo (in case you don't know, sudo is actually a program), Change My MAC need permission to access the file, and the sandbox blocks it. We already tried to make a Helper program to "execute" those privileged operations, but we ended up with no success... Anyways Change My MAC doesn't do anything strange to your system (you can see the source code if you want to check that by yourself).

#### How can I restore my orignal MAC Address???
Restart your mac, and you're good.

## Contributions
This program has been "readapted" from our main Python program (see the main repository brach), and [Natisfaction](https://github.com/Natisfaction) reworked the UI using Swift and SwiftUI.

## Licence
This repository is maintained under the MIT Licence.
