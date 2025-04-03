//
//  BluetoothScanningServiceImpl.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import Combine

final class BluetoothScanningServiceImpl: BluetoothScanningService {
    
    private let delegateHandler: BluetoothDelegateHandler
    
    init(delegateHandler: BluetoothDelegateHandler) {
        self.delegateHandler = delegateHandler
    }
    
    func startScanning() -> AnyPublisher<BluetoothDevice, Error> {
        delegateHandler.startScanning()
    }
    
    func stopScanning() {
        delegateHandler.stopScanning()
    }
}
