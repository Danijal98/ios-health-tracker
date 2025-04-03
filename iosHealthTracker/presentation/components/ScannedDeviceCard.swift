import SwiftUI


struct ScannedDeviceCard: View {
    let device: BluetoothDevice
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text("Name: \(device.name)")
                    .font(.body)
                
                Text("Address: \(device.address)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            RssiSignalIndicator(rssi: Int(device.signalStrength))
        }
    }
}

#Preview {
    ScannedDeviceCard(device: BluetoothDevice(name: "Device", address: "Some address", signalStrength: 100))
}
