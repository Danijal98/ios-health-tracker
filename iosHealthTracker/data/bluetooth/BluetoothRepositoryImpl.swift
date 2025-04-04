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
    private let historyDatabase: HistoryDatabase
    
    init(
        scanningService: BluetoothScanningService,
        connectionService: BluetoothConnectionService,
        historyDatabase: HistoryDatabase
    ) {
        self.scanningService = scanningService
        self.connectionService = connectionService
        self.historyDatabase = historyDatabase
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

    func saveData(_ healthData: HealthData) async -> Result<Void, BluetoothCollectionError> {
        do {
            try await historyDatabase.insert(healthData)
            return .success(())
        } catch {
            print("Save error: \(error)")
            return .failure(.savingError)
        }
    }
}
