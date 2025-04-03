//
//  BluetoothScanningService.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import Combine

protocol BluetoothScanningService {
    func startScanning() -> AnyPublisher<BluetoothDevice, Error>
    func stopScanning()
}
