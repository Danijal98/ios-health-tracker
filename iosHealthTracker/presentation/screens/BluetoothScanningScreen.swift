import SwiftUI

struct BluetoothScanningScreen: View {
    
    @ObservedObject private var viewModel: BluetoothScanningViewModel = BluetoothScanningViewModel()
    @ObservedObject var bluetoothManager = BluetoothManager()
    
    let sampleDevices: [BluetoothDevice] = [
        BluetoothDevice(name: "Heart Monitor", address: "AA:BB:CC:DD:EE:01", signalStrength: -45),
        BluetoothDevice(name: "Oximeter", address: "AA:BB:CC:DD:EE:02", signalStrength: -55),
        BluetoothDevice(name: "Fitness Band", address: "AA:BB:CC:DD:EE:03", signalStrength: -60)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if bluetoothManager.isBluetoothEnabled {
                    List(sampleDevices, id: \.address) { device in
                        NavigationLink(value: Screen.bluetoothDataCollectionScreen(deviceAddress: device.address)) {
                            ScannedDeviceCard(device: device)
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    
                    Button(action: {
                        // TODO: start or stop scanning
                    }) {
                        // TODO: start or stop scanning
                        Text("Start scanning")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
//                    .tint(viewModel.state.isScanning ? .red : .blue)
                } else {
                    EnableBluetoothPromptView()
                }
            }
            .padding()
            .onAppear {
                _ = bluetoothManager
            }
            .onDisappear {
                
            }
            .navigationTitle("Bluetooth Scanning")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Screen.self) { destination in
                switch destination {
                case .bluetoothDataCollectionScreen(let deviceAddress): BluetoothDataCollectionScreen(deviceAddress: deviceAddress)
                }
            }
        }
    }
}

#Preview {
    BluetoothScanningScreen()
}
