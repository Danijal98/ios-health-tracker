//
//  MockBluetoothRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation
import Combine

class MockBluetoothRepository: BluetoothRepository {
    
    private var timer: Timer?
    private var subject: PassthroughSubject<BluetoothDevice, Error>?
    
    func startScanning() -> AnyPublisher<BluetoothDevice, Error> {
        let subject = PassthroughSubject<BluetoothDevice, Error>()
        self.subject = subject // Save reference so we can call `.send` later

        // Start emitting mock devices every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let mockDevice = BluetoothDevice(
                name: ["Polar H10", "Garmin HRM", "Apple Watch", "Mock Tracker"].randomElement()!,
                address: UUID().uuidString,
                signalStrength: Int.random(in: -90 ... -40)
            )
            subject.send(mockDevice)
        }
        
        return subject
            .eraseToAnyPublisher()
    }
    
    func stopScanning() {
        timer?.invalidate()
        timer = nil
        subject?.send(completion: .finished)
        subject = nil // Clean up
    }
    
    func connectAndReadData(deviceAddress: String) -> AnyPublisher<HealthData, Error> {
        Empty().eraseToAnyPublisher()
    }
    
    func saveData(_ healthData: HealthData) async -> Result<Void, BluetoothCollectionError> {
        .success(())
    }
}
