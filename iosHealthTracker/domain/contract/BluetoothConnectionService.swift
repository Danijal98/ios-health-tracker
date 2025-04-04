//
//  BluetoothConnectionService.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//

import Combine

protocol BluetoothConnectionService {
    func connectAndReadData(deviceAddress: String) -> AnyPublisher<HealthData, Error>
}
