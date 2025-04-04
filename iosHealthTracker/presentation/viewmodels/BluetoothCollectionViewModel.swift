import Foundation
import Combine

@MainActor
class BluetoothCollectionViewModel: ObservableObject {
    
    @Published private(set) var state = BluetoothCollectionState()
    
    private let bluetoothRepository: BluetoothRepository
    private var dataCancellable: AnyCancellable?
    private let uiEventSubject = PassthroughSubject<BluetoothCollectionUIEvent, Never>()
    
    var uiEvents: AnyPublisher<BluetoothCollectionUIEvent, Never> {
        uiEventSubject.eraseToAnyPublisher()
    }
    
    init(repository: BluetoothRepository) {
        self.bluetoothRepository = repository
    }
    
    func onEvent(_ event: BluetoothCollectionEvent) {
        switch event {
        case .collectData(let deviceAddress):
            collectData(deviceAddress: deviceAddress)
        case .saveData(let healthData):
            Task {
                await saveData(healthData: healthData)
            }
        }
    }
    
    private func collectData(deviceAddress: String) {
        state.isCollecting = true
        state.error = nil
        state.collectedData = nil
        
        dataCancellable = bluetoothRepository.connectAndReadData(deviceAddress: deviceAddress)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure(_) = completion {
                    self.state.isCollecting = false
                    self.state.error = .collectingError
                }
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                
                let previous = self.state.collectedData ?? HealthData()
                let newData = HealthData(
                    heartRate: data.heartRate ?? previous.heartRate,
                    oxygenSaturation: data.oxygenSaturation ?? previous.oxygenSaturation
                )
                
                self.state.collectedData = newData
                
                if newData.heartRate != nil && newData.oxygenSaturation != nil {
                    self.state.isCollecting = false
                    self.dataCancellable?.cancel()
                }
            })
    }
    
    private func saveData(healthData: HealthData) async {
        state.isSaving = true
        let result = await bluetoothRepository.saveData(healthData)
        
        state.isSaving = false
        
        switch result {
        case .success:
            uiEventSubject.send(.saveSuccessful)
        case .failure:
            uiEventSubject.send(.saveUnsuccessful)
        }
    }
}
