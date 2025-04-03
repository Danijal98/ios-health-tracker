//
//  BluetoothRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import Combine

protocol BluetoothRepository {
    func connectAndReadData(deviceAddress: String) -> AnyPublisher<HealthData, Error>
    func saveData(_ healthData: HealthData) async -> Result<Void, BluetoothScanningError>
    func startScanning() -> AnyPublisher<BluetoothDevice, Error>
    func stopScanning()
}
