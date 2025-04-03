import SwiftUI

struct AverageHealthMetricCard: View {
    let title: String
    let averageValue: Int
    let minValue: Int
    let maxValue: Int
    let unit: String
    let icon: Image
    
    var body: some View {
        CardView {
            HStack(spacing: 16) {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    
                    Text("Average: \(averageValue)\(unit)")
                        .font(.subheadline)
                    Text("Min: \(minValue)\(unit) | Max: \(maxValue)\(unit)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    AverageHealthMetricCard(
        title: "Title",
        averageValue: 50,
        minValue: 0,
        maxValue: 100,
        unit: "bp",
        icon: Image(.oxygen)
    )
}
