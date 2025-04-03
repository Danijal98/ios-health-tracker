import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published private(set) var state = HomeState()
    
    private let userDetailsRepository: UserDetailsRepository
    private var loadDataTask: Task<Void, Never>? = nil
    
    init(userDetailsRepository: UserDetailsRepository) {
        self.userDetailsRepository = userDetailsRepository
    }
    
    func onEvent(_ event: HomeEvent) {
        switch event {
        case .loadData:
            loadData()
        }
    }
    
    private func loadData() {
        state.isLoading = true
        state.homeError = nil
        
        loadDataTask?.cancel()
        loadDataTask = Task {
            let result = await userDetailsRepository.getUserDetails()
            switch result {
            case .success(let data):
                state.userDetails = data
                state.isLoading = false
            case .failure(let error):
                state.homeError = error
                state.isLoading = false
            }
        }
    }
}
