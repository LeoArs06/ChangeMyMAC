import SwiftUI
import ServiceManagement

@main
struct UtilityApp: App {
    
    var body: some Scene {
        MenuBarExtra("Change My MAC", systemImage: "circle") {
            AppMenu()
        }.menuBarExtraStyle(.window)
        
        WindowGroup{}
    }
}

struct AppMenu: View {
    @State private var mac_add: String = ""
    @State private var interface: String = ""
    
    var body: some View {
        VStack {
            Text("Change My MAC").padding(.bottom)
            
            HStack {
                Text("Network Interface:  ")
                Menu {
                    Button(action: set_interface) {
                        Text("Interface")
                    }
                } label: {
                    Text("Network interface")
                }
            }
            .padding(.bottom)
            
            HStack {
                Text("New MAC Address: ")
                TextField("New MAC Address here...", text: $mac_add).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Divider().padding()
            
            HStack {
                Button(action: randomize) {
                    Text("Random MAC").padding()
                }
                Button(action: update_mac) {
                    Text("Update MAC‎").padding()
                }
            }
        }
        .padding()
    }
}

func randomize() {
    // Randomize the MAC
}

func update_mac() {
    // Update the MAC (maybe authenticate???)
}

func set_interface() {
    // Set the interface
}
