//
//  HistoryState.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/6/25.
//


struct HistoryState {
    var isLoading: Bool = false
    var error: HistoryError? = nil
    var historyList: [HealthData] = []
}

enum HistoryError: Error {
    case loadingError
    case clearHistoryError
    case defaultError
}
