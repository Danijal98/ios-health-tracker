//
//  BluetoothDelegateHandler.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import CoreBluetooth
import Combine

final class BluetoothDelegateHandler: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager!
    private var discoveredDeviceAddresses = Set<String>()
    private let serviceUUID = CBUUID(string: BluetoothConstants.healthMonitoringServiceUUID)
    
    // MARK: Scanning
    private let discoveredDeviceSubject = PassthroughSubject<BluetoothDevice, Error>()
    func startScanning() -> AnyPublisher<BluetoothDevice, Error> {
        discoveredDeviceAddresses.removeAll()
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        } else {
            return Fail(error: BluetoothScanningError.scanningError).eraseToAnyPublisher()
        }
        return discoveredDeviceSubject.eraseToAnyPublisher()
    }
    
    func stopScanning() {
        centralManager.stopScan()
        discoveredDeviceAddresses.removeAll()
    }
    
    // MARK: Connection + Reading
    var onHealthDataReceived: ((HealthData) -> Void)?
    var onPeripheralConnected: ((CBPeripheral) -> Void)?
    var targetDeviceAddressToConnect: String?
    
    private var connectedPeripheral: CBPeripheral?
    private var characteristicQueue = [CBCharacteristic]()
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func beginScanForConnection() {
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
    }

    func endScanAndDisconnect() {
        centralManager.stopScan()
        cancelConnection()
        resetConnectionState()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Bluetooth state changed to: \(central.state.rawValue)")
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi RSSI: NSNumber
    ) {
        let address = peripheral.identifier.uuidString
        
        if let target = targetDeviceAddressToConnect, target == address {
            central.stopScan()
            connectedPeripheral = peripheral
            connectedPeripheral?.delegate = self
            central.connect(peripheral, options: nil)
            return
        }
        
        guard !discoveredDeviceAddresses.contains(address) else { return }
        discoveredDeviceAddresses.insert(address)
        
        let device = BluetoothDevice(
            name: peripheral.name ?? "Unknown Device",
            address: address,
            signalStrength: RSSI.intValue
        )
        
        discoveredDeviceSubject.send(device)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.identifier.uuidString)")
        connectedPeripheral = peripheral
        connectedPeripheral?.delegate = self
        onPeripheralConnected?(peripheral)
        peripheral.discoverServices([serviceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil, let services = peripheral.services else {
            print("Failed to discover services: \(error?.localizedDescription ?? "unknown error")")
            return
        }
        
        if let service = services.first(where: { $0.uuid == serviceUUID }) {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil, let characteristics = service.characteristics else {
            print("Failed to discover characteristics: \(error?.localizedDescription ?? "unknown error")")
            return
        }
        
        for char in characteristics {
            if char.uuid == CBUUID(string: BluetoothConstants.heartRateCharacteristicUUID) ||
                char.uuid == CBUUID(string: BluetoothConstants.oxygenSaturationCharacteristicUUID) {
                characteristicQueue.append(char)
            }
        }
        
        readNextCharacteristic(peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil, let value = characteristic.value else {
            readNextCharacteristic(peripheral)
            return
        }
        
        let byte = value.first.map { Int($0) }
        let uuid = characteristic.uuid
        
        if uuid == CBUUID(string: BluetoothConstants.heartRateCharacteristicUUID), let heartRate = byte {
            onHealthDataReceived?(HealthData(heartRate: heartRate))
        } else if uuid == CBUUID(string: BluetoothConstants.oxygenSaturationCharacteristicUUID), let oxygen = byte {
            onHealthDataReceived?(HealthData(oxygenSaturation: oxygen))
        }
        
        readNextCharacteristic(peripheral)
    }
    
    private func readNextCharacteristic(_ peripheral: CBPeripheral) {
        guard !characteristicQueue.isEmpty else { return }
        let next = characteristicQueue.removeFirst()
        peripheral.readValue(for: next)
    }
    
    func resetConnectionState() {
        targetDeviceAddressToConnect = nil
        onPeripheralConnected = nil
        onHealthDataReceived = nil
        connectedPeripheral = nil
        characteristicQueue.removeAll()
    }
    
    func cancelConnection() {
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
        }
    }
}
