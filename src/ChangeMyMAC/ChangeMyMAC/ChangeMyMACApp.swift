import SwiftUI
import Foundation

@main
struct ChangeMyMAC: App {
    var body: some Scene {
        MenuBarExtra("Change My MAC", systemImage: "circle") {
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
                
                Button {
                    
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
            }
            .padding(.bottom)
            
            HStack {
                Text("New MAC Address: ")
                
                // MAC Address field
                TextField("New MAC Address here...", text: $mac_add)
                    .textFieldStyle(.roundedBorder)
                
            }
            
            Divider()
                .padding()
            
            HStack {
                Button {
                    randomize()
                } label: {
                    Text("Random MAC").frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                
                Button {
                    update_mac()
                } label: {
                    Text("Update MAC").frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
            }
        }
        .padding()
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
