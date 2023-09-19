import SwiftUI
import Foundation
import ServiceManagement

@main
struct ChangeMyMAC: App {
    var body: some Scene {
        MenuBarExtra("Change My MAC", systemImage: "arrow.triangle.2.circlepath") {
            AppMenu()
        }
        .menuBarExtraStyle(.window)
        WindowGroup {}
    }
}

struct AppMenu: View {
    // MAC Address and selecter interface
    @State private var mac_add: String = ""
    @State private var sInterface: String = ""
    @State private var About = false
    
    @State private var mac: String = ""
    
    // Network Interfaces
    private var interfaces: [String] {
        getInterfaces()
    }
    
    var body: some View {
        VStack {
            // Title
            HStack(alignment: .firstTextBaseline) {
                Text("Change My MAC")
                    .padding(.bottom)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Menu {
                    Button {
                        NSApplication.shared.terminate(nil)
                    } label: {
                        Text("Exit")
                    }
                    
                    Button {
                        About = true
                    } label: {
                        Text("About")
                    }
                } label: {
                    Text("⚙️")
                        .padding(.bottom)
                        .font(.title)
                        .fontWeight(.bold)
                    
                }.buttonStyle(.borderless)
            }
            
            HStack {
                Text("Network Interface:  ")
                
                Menu {
                    // This snipped simply creates buttons with the interface name
                    ForEach(interfaces, id: \.self) { interface in
                        Button(action: {
                            sInterface = interface
                        }) {
                            Text(interface)
                        }
                    }
                } label: {
                    Text(sInterface.isEmpty ? "Network interface" : sInterface)
                }
                .onChange(of: sInterface) { interface in
                    getMAC(interface)
                }
            }
            .padding(.bottom)
            
            HStack {
                Text("New MAC Address: ")
                
                // MAC Address field
                TextField(sInterface.isEmpty ? "Interface's MAC" : mac, text: $mac_add)
                    .textFieldStyle(.roundedBorder)
            }
            
            Divider()
                .padding()
            
            HStack {
                Button {
                    randomize()
                } label: {
                    Text("Random MAC")
                        .frame(maxWidth: .infinity)
                }
                
                Button {
                    update_mac()
                } label: {
                    Text("Update MAC")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding().sheet(isPresented: $About) {
            AboutView(isPresented: $About)
        }
    }
    
    func randomize() {
        let mac_nibble: [Character] = Array("0123456789abcdef")
        var newmac: String = ""
        
        // First nibble random
        if let randomNibble = mac_nibble.randomElement() {
            newmac.append(randomNibble)
        }
        
        // Second nibble ONLY odd
        if let randomNibble = ["0", "2", "4", "6", "8", "a", "c", "e"].randomElement() {
            newmac.append(randomNibble)
        }
        
        // MAC Address bytes
        for _ in 0...4 {
            newmac.append(":")
            for _ in 0...1 {
                if let randomNibble = mac_nibble.randomElement() {
                    newmac.append(randomNibble)
                }
            }
        }
        
        mac_add = newmac
    }
    
    func getMAC(_ iface: String) {
        // Process and Pipe
        let process = Process()
        let pipe = Pipe()
        var output: String = ""
        
        // Run the commands, and return the second column (the MAC Address)
        process.standardOutput = pipe
        process.arguments = ["-c", "ifconfig \(iface) | grep ether | awk '{print $2}'"]
        process.launchPath = "/bin/bash"
        process.launch()
        
        // Using the Pipe, return the string
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .newlines) ?? ""
        process.waitUntilExit()
        
        mac = output
    }
    
    func getInterfaces() -> [String] {
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        var sortedNames: [String] = []
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            
            // Remove duplicates
            var interfaceNames = Set<String>()
            
            while ptr != nil {
                if let interfaceName = String(cString: (ptr?.pointee.ifa_name)!).components(separatedBy: ":").first {
                    interfaceNames.insert(interfaceName)
                }
                
                ptr = ptr?.pointee.ifa_next
            }
            
            freeifaddrs(ifaddr)
            
            // Sort them alphabetically
            sortedNames = interfaceNames.sorted()
        }
        
        return sortedNames
    }
    
    func isMACvalid() -> Bool{
        // Check if the MAC address is valid
        let macRegex = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$"
        
        let macPredicate = NSPredicate(format: "SELF MATCHES %@", macRegex)
        return macPredicate.evaluate(with: mac_add)
    }
    
    func update_mac() {
        // Check if the interface has a MAC Address
        if mac.isEmpty {
            let alert = NSAlert()
            
            alert.messageText = "No MAC Address"
            alert.informativeText = "The interface you provided does not have a MAC Address and thus, you can't change it"
            alert.addButton(withTitle: "OK")
            
            if let iconImage = NSImage(named: "Error") {
                alert.icon = iconImage
            }
            
            let _ = alert.runModal()
            return
        }
        
        // Check if the MAC address is valid and the interface is selected, if not display an error
        if sInterface.isEmpty || !isMACvalid() {
            let alert = NSAlert()
            
            alert.messageText = "Invalid prompts"
            alert.informativeText = "Please type in the requested data correctly"
            alert.addButton(withTitle: "OK")
            
            if let iconImage = NSImage(named: "Error") {
                alert.icon = iconImage
            }
            
            let _ = alert.runModal()
            return
        }
        
        // Prompt the user for the password
        let alert = NSAlert()
        
        alert.messageText = "Root password required"
        alert.informativeText = "Please enter your root password:"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let passwordTextField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        alert.accessoryView = passwordTextField
        
        if let iconImage = NSImage(named: NSImage.lockLockedTemplateName) {
            alert.icon = iconImage
        }
        
        let response = alert.runModal()
        
        if response == .alertFirstButtonReturn {
            
            // If the OK button is clicked, the password gets written to the pipe
            if let password = passwordTextField.stringValue.data(using: .utf8) {
                
                // Check if the password provided is correct
                let process = Process()
                process.launchPath = "/usr/bin/sudo"
                process.arguments = ["-S", "/usr/bin/true"]
                
                let pipe = Pipe()
                process.standardInput = pipe
                let fileHandle = pipe.fileHandleForWriting
                
                fileHandle.write(password)
                fileHandle.closeFile()
                
                process.launch()
                process.waitUntilExit()
                
                if process.terminationStatus == 0 {
                    
                    // If the password is correct, update the MAC address
                    let updateProcess = Process()
                    
                    // Run the process with sudo, dissociate the connection from airport, and change the MAC Address
                    updateProcess.launchPath = "/usr/bin/sudo"
                    updateProcess.arguments = ["-S", "sh", "-c", "sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z && ifconfig \(sInterface) ether \(mac_add)"]
                    
                    let updatePipe = Pipe()
                    updateProcess.standardInput = updatePipe
                    let updateFileHandle = updatePipe.fileHandleForWriting
                    
                    updateFileHandle.write(password)
                    updateFileHandle.closeFile()
                    
                    updateProcess.launch()
                    updateProcess.waitUntilExit()
                    
                    // If the password is correct, display the success alert
                    let success = NSAlert()
                    
                    success.messageText = "Success"
                    success.informativeText = "Successfully updated your MAC Address!"
                    success.addButton(withTitle: "OK")
                    
                    if let iconImage = NSImage(named: "Success") {
                        success.icon = iconImage
                    }
                    
                    let _ = success.runModal()
                    
                    // Refresh the MAC Address
                    getMAC(sInterface)
                    
                    // Remove the old one
                    mac_add = ""
                    
                } else {
                    
                    // If the passowrd is incorrect, display an error alert
                    let errorAlert = NSAlert()
                    
                    errorAlert.messageText = "Incorrect password"
                    errorAlert.informativeText = "Please enter the correct root password."
                    errorAlert.addButton(withTitle: "OK")
                    
                    if let iconImage = NSImage(named: "Error") {
                        errorAlert.icon = iconImage
                    }
                    
                    let _ = errorAlert.runModal()
                }
            }
        }
    }
}

struct AboutView: View {
    // Cannot be private
    @Binding var isPresented: Bool
    
    @State private var version: String = "2.1"
    @State private var build: String = "2"
    @State private var years: String = "2023"
    
    var body: some View {
        VStack {
            HStack {
                Text("ChangeMyMAC")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .padding(.top)
            }
            
            Text("Copyright (c) \(years) Natisfaction, LeoArs06")
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Info")
                .font(.body)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all)
            
            Text("ChangeMyMAC version \(version), build \(build)")
                .padding(.bottom)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                VStack {
                    Text("Developed by")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Link("Natisfaction", destination: URL(string: "https://github.com/Natisfaction")!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Link("LeoArs06", destination: URL(string: "https://github.com/LeoArs06")!)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text("UI Designed by")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Link("Natisfaction", destination: URL(string: "https://github.com/Natisfaction")!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }

                Image("App")
                
                Spacer()
            }
            
            HStack {
                Button {
                    //
                } label: {
                    Link("GitHub", destination: URL(string: "https://github.com/LeoArs06/ChangeMyMAC/tree/macOS")!)
                        .frame(maxWidth: .infinity)
                }.padding(.horizontal)

                Divider()

                Button {
                    isPresented = false
                } label: {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                }.padding(.horizontal)
                
            }.padding(.top)
            
        }.padding(.all)
            .frame(width: 350, height: 400)
    }
}
