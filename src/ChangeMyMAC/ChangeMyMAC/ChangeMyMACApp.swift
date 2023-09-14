import SwiftUI
import ServiceManagement
import SystemConfiguration

import Darwin
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
            // Title (I'll format the string better later)...
            Text("Change My MAC")
                .padding(.bottom)
            
            HStack {
                Text("Network Interface: ")
                
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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Divider()
                .padding()
            
            HStack {
                Button(action: randomize) {
                    Text("Random MAC")
                        .padding()
                }
                
                Button(action: update_mac) {
                    Text("Update MAC")
                        .padding()
                }
            }
        }
        .padding()
    }
    
    func printa(cfArray: CFArray) {
        print(cfArray)
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

    func update_mac() {
        // Update the MAC (maybe authenticate???)
    }
}
