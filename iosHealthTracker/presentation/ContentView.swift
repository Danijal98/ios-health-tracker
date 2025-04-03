//
//  ContentView.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    
    private let container = AppDIContainer()
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeScreen(repository: container.userDetailsRepository)
            }
            
            Tab("Bluetooth", systemImage: "sensor.tag.radiowaves.forward") {
                BluetoothScanningScreen()
            }
            
            Tab("History", systemImage: "list.bullet") {
                HistoryScreen()
            }
            
            Tab("Settings", systemImage: "gearshape") {
                SettingsScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
