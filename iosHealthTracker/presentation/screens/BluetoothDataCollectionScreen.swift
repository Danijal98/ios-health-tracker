import SwiftUI

struct BluetoothDataCollectionScreen: View {
    
    @ObservedObject private var viewModel: BluetoothCollectionViewModel = BluetoothCollectionViewModel()
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var showSaveAlert = false
    @State private var showUnsuccessfulSaveAlert = false
    
    let deviceAddress: String
    
    let sampleCollectedData = HealthData(id: 0, heartRate: 100, oxygenSaturation: 100, createdTime: nil)
    
    var body: some View {
        VStack {
            if bluetoothManager.isBluetoothEnabled {
                DataCollectedCard(
                    data: sampleCollectedData,
                    isSaving: false,
                    onSave: { data in
                        
                    }
                )
                
                Spacer()
                
                LoaderButton(
                    text: "Collect data",
                    isLoading: false,
                    fullWidth: true,
                    onClick: {}
                )
            } else {
                EnableBluetoothPromptView()
            }
        }
        .padding()
        .alert("Success", isPresented: $showSaveAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("Successfully saved")
        }
        .alert("Failiure", isPresented: $showUnsuccessfulSaveAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("Save failed")
        }
        .onAppear {
            _ = bluetoothManager
        }
        .onDisappear {
            
        }
        .navigationTitle("Data collect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BluetoothDataCollectionScreen(deviceAddress: "123:1312:12412:42413")
}
