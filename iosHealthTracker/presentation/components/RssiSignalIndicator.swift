import SwiftUI


struct RssiSignalIndicator: View {
    let rssi: Int
    
    var body: some View {
        getRssiImage(getSignalLevel(rssi))
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
    }
}

// Determines signal level based on RSSI value
func getSignalLevel(_ rssi: Int) -> Int {
    switch rssi {
    case (-50)...Int.max: return 5  // Excellent signal (5 bars)
    case (-60)...(-51): return 4    // Very good signal (4 bars)
    case (-67)...(-61): return 3    // Good signal (3 bars)
    case (-70)...(-68): return 2    // Fair signal (2 bars)
    case (-80)...(-71): return 1    // Weak signal (1 bar)
    default: return 0  // No signal (0 bars)
    }
}

// Maps signal levels to respective image names
private func getRssiImage(_ level: Int) -> Image {
    switch level {
    case 5: return Image(.signal5)
    case 4: return Image(.signal4)
    case 3: return Image(.signal3)
    case 2: return Image(.signal2)
    case 1: return Image(.signal1)
    default: return Image(.signalUnavailable)
    }
}

#Preview("5") {
    RssiSignalIndicator(rssi: -50)
}

#Preview("4") {
    RssiSignalIndicator(rssi: -60)
}

#Preview("3") {
    RssiSignalIndicator(rssi: -67)
}

#Preview("2") {
    RssiSignalIndicator(rssi: -70)
}

#Preview("1") {
    RssiSignalIndicator(rssi: -80)
}

#Preview("Signal unavailable") {
    RssiSignalIndicator(rssi: -90)
}
