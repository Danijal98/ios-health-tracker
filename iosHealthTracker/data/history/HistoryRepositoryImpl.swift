//
//  HistoryRepositoryImpl.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/6/25.
//


import Foundation

final class HistoryRepositoryImpl: HistoryRepository {
    
    private let historyDatabase: HistoryDatabase
    
    init(historyDatabase: HistoryDatabase) {
        self.historyDatabase = historyDatabase
    }
    
    func getHistory() async -> Result<[HealthData], HistoryError> {
        do {
            let result = try await historyDatabase.getAll()
            return .success(result)
        } catch {
            print("Get history error: \(error)")
            return .failure(.loadingError)
        }
    }
    
    func clearHistory() async -> Result<Void, HistoryError> {
        do {
            try await historyDatabase.deleteAll()
            return .success(())
        } catch {
            print("Clear history error: \(error)")
            return .failure(.clearHistoryError)
        }
    }
}
