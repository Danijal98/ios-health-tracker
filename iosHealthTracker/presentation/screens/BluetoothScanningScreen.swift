import SwiftUI

struct BluetoothScanningScreen: View {
    
    @StateObject private var viewModel: BluetoothScanningViewModel
    @ObservedObject private var bluetoothManager = BluetoothManager()
    
    init(repository: BluetoothRepository) {
        _viewModel = StateObject(wrappedValue: BluetoothScanningViewModel(bluetoothRepository: repository))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if bluetoothManager.isBluetoothEnabled {
                    if let error = viewModel.state.error {
                        switch error {
                        case .scanningError:
                            Text("Failed to scan for devices.")
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .defaultError:
                            Text("Unknown error occurred.")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } else {
                        List(viewModel.state.scannedDevices) { device in
                            NavigationLink(destination: BluetoothDataCollectionScreen(deviceAddress: device.address)) {
                                ScannedDeviceCard(device: device)
                            }
                            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    }
                    
                    Button(action: {
                        if viewModel.state.isScanning {
                            viewModel.onEvent(.stopScanning)
                        } else {
                            viewModel.onEvent(.startScanning)
                        }
                    }) {
                        Text(viewModel.state.isScanning ? "Stop Scanning" : "Start Scanning")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(viewModel.state.isScanning ? .red : .blue)
                } else {
                    EnableBluetoothPromptView()
                }
            }
            .padding()
            .onAppear {
                _ = bluetoothManager
            }
            .onDisappear {
                viewModel.onEvent(.stopScanning)
            }
            .navigationTitle("Bluetooth Scanning")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BluetoothScanningScreen(repository: MockBluetoothRepository())
}
