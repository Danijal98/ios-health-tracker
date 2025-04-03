//
//  BluetoothDevice.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//

import Foundation

struct BluetoothDevice: Identifiable, Codable, Equatable {
    var id: String { address }
    let name: String
    let address: String
    let signalStrength: Int
}
