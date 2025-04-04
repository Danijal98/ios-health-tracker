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
    private let connectionService: BluetoothConnectionService
    
    init(
        scanningService: BluetoothScanningService,
        connectionService: BluetoothConnectionService
    ) {
        self.scanningService = scanningService
        self.connectionService = connectionService
    }
    
    func startScanning() -> AnyPublisher<BluetoothDevice, Error> {
        scanningService.startScanning()
    }

    func stopScanning() {
        scanningService.stopScanning()
    }

    func connectAndReadData(deviceAddress: String) -> AnyPublisher<HealthData, Error> {
        connectionService.connectAndReadData(deviceAddress: deviceAddress)
    }

    func saveData(_ healthData: HealthData) async -> Result<Void, BluetoothScanningError> {
        .success(())
    }
}
