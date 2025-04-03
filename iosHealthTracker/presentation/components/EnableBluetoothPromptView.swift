import SwiftUI

struct EnableBluetoothPromptView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)

            Text("Bluetooth turned off")
                .font(.headline)

            Text("Turn on bluetooth")
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    EnableBluetoothPromptView()
}
