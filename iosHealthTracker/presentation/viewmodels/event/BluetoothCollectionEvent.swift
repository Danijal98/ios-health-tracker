//
//  BluetoothCollectionEvent.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//


enum BluetoothCollectionEvent {
    case collectData(deviceAddress: String)
    case saveData(healthData: HealthData)
}
