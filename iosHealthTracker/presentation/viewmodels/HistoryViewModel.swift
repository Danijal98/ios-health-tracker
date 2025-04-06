//
//  HistoryViewModel 2.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/6/25.
//


import Foundation
import Combine

@MainActor
class HistoryViewModel: ObservableObject {
    
    @Published private(set) var state = HistoryState()
    
    private let historyRepository: HistoryRepository
    private let uiEventSubject = PassthroughSubject<HistoryUIEvent, Never>()
    
    var uiEvents: AnyPublisher<HistoryUIEvent, Never> {
        uiEventSubject.eraseToAnyPublisher()
    }
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func onEvent(_ event: HistoryEvent) {
        switch event {
        case .loadData:
            loadData()
        case .clearHistory:
            clearHistory()
        }
    }
    
    private func loadData() {
        state.isLoading = true
        Task {
            let result = await historyRepository.getHistory()
            switch result {
            case .success(let data):
                state.historyList = data
                state.isLoading = false
            case .failure(let error):
                state.isLoading = false
                state.error = error
            }
        }
    }
    
    private func clearHistory() {
        guard !state.historyList.isEmpty else { return }
        state.isLoading = true
        Task {
            let result = await historyRepository.clearHistory()
            switch result {
            case .success:
                state.historyList = []
                state.isLoading = false
                uiEventSubject.send(.historyClearedSuccessfully)
            case .failure(let error):
                state.isLoading = false
                state.error = error
            }
        }
    }
}
