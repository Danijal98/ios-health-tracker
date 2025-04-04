//
//  AppDIContainer.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

final class AppDIContainer {
    
    // MARK: - Services
    let userDetailsService: UserDetailsService
    let bluetoothScanningService: BluetoothScanningService
    let bluetoothConnectionService: BluetoothConnectionService

    // MARK: - Repositories
    let userDetailsRepository: UserDetailsRepository
    let bluetoothRepository: BluetoothRepository
    
    init() {
        // Bluetooth delegate handler
        let delegateHandler = BluetoothDelegateHandler()
        
        // Initialize services
        self.userDetailsService = UserDetailsServiceImpl()
        self.bluetoothScanningService = BluetoothScanningServiceImpl(delegateHandler: delegateHandler)
        self.bluetoothConnectionService = BluetoothConnectionServiceImpl(delegateHandler: delegateHandler)
        
        // Initialize repositories
        self.userDetailsRepository = UserDetailsRepositoryImpl(
            userDetailsService: userDetailsService
        )
        
        self.bluetoothRepository = BluetoothRepositoryImpl(
            scanningService: bluetoothScanningService,
            connectionService: bluetoothConnectionService
        )
    }
}
