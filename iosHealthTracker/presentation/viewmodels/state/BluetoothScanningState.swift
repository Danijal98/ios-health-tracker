//
//  BluetoothScanningState.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

struct BluetoothScanningState {
    var isScanning: Bool = false
    var error: BluetoothScanningError? = nil
    var scannedDevices: [BluetoothDevice] = []
}

enum BluetoothScanningError: Error {
    case scanningError
    case defaultError
}
