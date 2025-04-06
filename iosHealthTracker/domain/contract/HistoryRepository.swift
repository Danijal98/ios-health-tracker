//
//  HistoryRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/6/25.
//


import Foundation

protocol HistoryRepository {
    func getHistory() async -> Result<[HealthData], HistoryError>
    func clearHistory() async -> Result<Void, HistoryError>
}
