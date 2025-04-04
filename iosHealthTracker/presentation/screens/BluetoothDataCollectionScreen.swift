import SwiftUI

struct BluetoothDataCollectionScreen: View {
    
    @StateObject private var viewModel: BluetoothCollectionViewModel
    @ObservedObject var bluetoothManager = BluetoothManager()
    
    @State private var showSaveAlert = false
    @State private var showUnsuccessfulSaveAlert = false
    
    let deviceAddress: String
    
    init(repository: BluetoothRepository, deviceAddress: String) {
        _viewModel = StateObject(wrappedValue: BluetoothCollectionViewModel(repository: repository))
        self.deviceAddress = deviceAddress
    }
    
    var body: some View {
        VStack {
            if bluetoothManager.isBluetoothEnabled {
                if let error = viewModel.state.error {
                    switch error {
                    case .collectingError:
                        UnknownErrorState(text: "Error collecting data") {
                            viewModel.onEvent(.collectData(deviceAddress: deviceAddress))
                        }
                    case .savingError:
                        EmptyView()
                    }
                } else {
                    if let data = viewModel.state.collectedData {
                        DataCollectedCard(
                            data: data,
                            isSaving: viewModel.state.isSaving,
                            onSave: { data in
                                viewModel.onEvent(.saveData(healthData: data))
                            }
                        )
                    }
                    
                    Spacer()
                    
                    LoaderButton(
                        text: "Collect Data",
                        isLoading: viewModel.state.isCollecting,
                        fullWidth: true,
                        onClick: {
                            viewModel.onEvent(.collectData(deviceAddress: deviceAddress))
                        }
                    )
                }
            } else {
                EnableBluetoothPromptView()
            }
        }
        .padding()
        .alert("Success", isPresented: $showSaveAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Data saved successfully.")
        }
        .alert("Failure", isPresented: $showUnsuccessfulSaveAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Failed to save data.")
        }
        .onReceive(viewModel.uiEvents) { event in
            switch event {
            case .saveSuccessful:
                showSaveAlert = true
            case .saveUnsuccessful:
                showUnsuccessfulSaveAlert = true
            }
        }
        .navigationTitle("Device: \(deviceAddress)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BluetoothDataCollectionScreen(
        repository: MockBluetoothRepository(),
        deviceAddress: "123:1312:12412:42413"
    )
}
