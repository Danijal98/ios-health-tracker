//
//  BluetoothConnectionServiceImpl.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//


import Foundation
import Combine
import CoreBluetooth

final class BluetoothConnectionServiceImpl: BluetoothConnectionService {
    
    private let delegateHandler: BluetoothDelegateHandler
    private let serviceUUID = CBUUID(string: BluetoothConstants.healthMonitoringServiceUUID)
    
    init(delegateHandler: BluetoothDelegateHandler) {
        self.delegateHandler = delegateHandler
    }
    
    func connectAndReadData(deviceAddress: String) -> AnyPublisher<HealthData, Error> {
        let subject = PassthroughSubject<HealthData, Error>()
        
        delegateHandler.targetDeviceAddressToConnect = deviceAddress
        delegateHandler.onHealthDataReceived = { data in
            subject.send(data)
        }
        
        delegateHandler.onPeripheralConnected = { peripheral in
            print("Peripheral connected: \(peripheral.identifier)")
        }
        
        delegateHandler.beginScanForConnection()
        
        return subject
            .handleEvents(receiveCancel: { [weak self] in
                print("Flow canceled, cleaning up")
                self?.delegateHandler.endScanAndDisconnect()
            })
            .eraseToAnyPublisher()
    }
}
