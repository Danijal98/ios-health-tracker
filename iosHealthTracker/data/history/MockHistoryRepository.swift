//
//  MockHistoryRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/6/25.
//


import Foundation

final class MockHistoryRepository: HistoryRepository {
    
    var mockData: [HealthData] = [
        HealthData(heartRate: 75, oxygenSaturation: 96),
        HealthData(heartRate: 82, oxygenSaturation: 98),
        HealthData(heartRate: 70, oxygenSaturation: 95)
    ]
    
    func getHistory() async -> Result<[HealthData], HistoryError> {
        .success(mockData)
    }
    
    func clearHistory() async -> Result<Void, HistoryError> {
        mockData = []
        return .success(())
    }
}
