//
//  BluetoothDevice.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//

import Foundation

struct BluetoothDevice: Codable, Equatable {
    let name: String
    let address: String
    let signalStrength: Int
}
