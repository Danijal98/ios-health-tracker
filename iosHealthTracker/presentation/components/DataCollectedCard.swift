import SwiftUI

struct DataCollectedCard: View {
    let data: HealthData
    let isSaving: Bool
    let onSave: (HealthData) -> Void

    var body: some View {
        CardView {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Heart rate: \(String(data.heartRate ?? 0))")
                        .font(.body)

                    Text("Oxygen saturation value: \(String(data.oxygenSaturation ?? 0))")
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                LoaderButton(
                    text: "Save",
                    isLoading: isSaving,
                    onClick: {
                        onSave(data)
                    }
                )
            }
        }
    }
}

#Preview {
    DataCollectedCard(
        data: HealthData(heartRate: 80, oxygenSaturation: 100),
        isSaving: false,
        onSave: { data in }
    )
}
