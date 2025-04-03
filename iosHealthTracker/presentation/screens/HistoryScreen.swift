import SwiftUI

struct HistoryScreen: View {
    
    @ObservedObject private var viewModel: HistoryViewModel = HistoryViewModel()
    @State private var showSaveAlert = false
    
    let sampleHealthData: [HealthData] = [
        HealthData(id: 1, heartRate: 72, oxygenSaturation: 98, createdTime: "2024-04-03 10:15"),
        HealthData(id: 2, heartRate: 78, oxygenSaturation: 96, createdTime: "2024-04-03 10:20"),
        HealthData(id: 3, heartRate: 85, oxygenSaturation: 97, createdTime: "2024-04-03 10:25")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(sampleHealthData, id: \.id) { item in
                    HistoryListItemCard(healthData: item)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                
            }
            .onDisappear {
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive) {
                            
                        } label: {
                            Label("Clear history", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .alert("Success", isPresented: $showSaveAlert) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text("History cleared")
            }
        }
    }
}

#Preview {
    HistoryScreen()
}
