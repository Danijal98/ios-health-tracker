//
//  BluetoothCollectionState.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/4/25.
//


struct BluetoothCollectionState {
    var isCollecting: Bool = false
    var isSaving: Bool = false
    var error: BluetoothCollectionError? = nil
    var collectedData: HealthData? = nil
}

enum BluetoothCollectionError: Error {
    case collectingError
    case savingError
}
