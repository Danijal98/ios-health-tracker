import Foundation

import Foundation
import Combine

@MainActor
class BluetoothScanningViewModel: ObservableObject {
    
    @Published private(set) var state = BluetoothScanningState()
    
    private let bluetoothRepository: BluetoothRepository
    private var scanningCancellable: AnyCancellable?
    
    private var scannedDevices: [String: BluetoothDevice] = [:]
    
    init(bluetoothRepository: BluetoothRepository) {
        self.bluetoothRepository = bluetoothRepository
    }
    
    func onEvent(_ event: BluetoothScanningEvent) {
        switch event {
        case .startScanning:
            startScanning()
        case .stopScanning:
            stopScanning()
        }
    }
    
    private func startScanning() {
        scanningCancellable = bluetoothRepository.startScanning()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.state.isScanning = true
                self?.state.error = nil
            })
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.state.isScanning = false
                switch completion {
                case .failure:
                    self.state.error = .scanningError
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] device in
                guard let self = self else { return }
                self.scannedDevices[device.address] = device
                self.state.scannedDevices = Array(self.scannedDevices.values)
            })
    }
    
    private func stopScanning() {
        bluetoothRepository.stopScanning()
        scanningCancellable?.cancel()
        scanningCancellable = nil
        
        state.isScanning = false
        state.scannedDevices = []
        scannedDevices.removeAll()
    }
}
