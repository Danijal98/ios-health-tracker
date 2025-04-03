import SwiftUI

struct HistoryListItemCard: View {
    let healthData: HealthData
    
    var body: some View {
        CardView {
            HStack(spacing: 16) {
                Image(.data)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading) {
                    Text("Recorded data: \(healthData.createdTime ?? "/")")
                        .font(.headline)
                    
                    let heartRateString = healthData.heartRate.map { "\($0)\("bpm")" } ?? "/"
                    let oxygenSaturationString = healthData.oxygenSaturation.map { "\($0)\("%")" } ?? "/"
                    
                    Text("Heart rate: \(heartRateString)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Oxygen saturation: \(oxygenSaturationString)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    HistoryListItemCard(healthData: HealthData(
        id: 0, heartRate: 80, oxygenSaturation: 100, createdTime: "Today"
    ))
}
