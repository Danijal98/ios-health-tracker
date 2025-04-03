//
//  BluetoothRepositoryImpl.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import Combine

final class BluetoothRepositoryImpl: BluetoothRepository {
    
    private let scanningService: BluetoothScanningService
    
    init(scanningService: BluetoothScanningService) {
        self.scanningService = scanningService
    }
    
    func startScanning() -> AnyPublisher<BluetoothDevice, Error> {
        scanningService.startScanning()
    }
    
    func stopScanning() {
        scanningService.stopScanning()
    }
    
    // Other methods (connectAndReadData, saveData) will be implemented later
    func connectAndReadData(deviceAddress: String) -> AnyPublisher<HealthData, Error> {
        Empty().eraseToAnyPublisher()
    }
    
    func saveData(_ healthData: HealthData) async -> Result<Void, BluetoothScanningError> {
        .success(())
    }
}
