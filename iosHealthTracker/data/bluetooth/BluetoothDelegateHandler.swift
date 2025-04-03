//
//  BluetoothDelegateHandler.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import CoreBluetooth
import Combine

final class BluetoothDelegateHandler: NSObject, CBCentralManagerDelegate {
    
    private var centralManager: CBCentralManager!
    private var discoveredDeviceAddresses = Set<String>()
    
    private let discoveredDeviceSubject = PassthroughSubject<BluetoothDevice, Error>()
    private let serviceUUID = CBUUID(string: BluetoothConstants.healthMonitoringServiceUUID)
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() -> AnyPublisher<BluetoothDevice, Error> {
        discoveredDeviceAddresses.removeAll()
        
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        } else if centralManager.state == .poweredOff {
            return Fail(error: BluetoothScanningError.scanningError).eraseToAnyPublisher()
        }
        
        return discoveredDeviceSubject.eraseToAnyPublisher()
    }

    func stopScanning() {
        centralManager.stopScan()
        discoveredDeviceAddresses.removeAll()
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Bluetooth state changed to: \(central.state.rawValue)")
        // You can trigger scanning here if needed
    }

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi RSSI: NSNumber
    ) {
        let address = peripheral.identifier.uuidString
        
        guard !discoveredDeviceAddresses.contains(address) else { return }
        discoveredDeviceAddresses.insert(address)
        
        let device = BluetoothDevice(
            name: peripheral.name ?? "Unknown Device",
            address: address,
            signalStrength: RSSI.intValue
        )
        
        discoveredDeviceSubject.send(device)
    }
}
