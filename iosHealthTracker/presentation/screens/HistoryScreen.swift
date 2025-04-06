import SwiftUI

struct HistoryScreen: View {
    
    @StateObject private var viewModel: HistoryViewModel
    @State private var showClearedAlert = false
    
    init(historyRepository: HistoryRepository) {
        _viewModel = StateObject(wrappedValue: HistoryViewModel(historyRepository: historyRepository))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let error = viewModel.state.error {
                    switch error {
                    case .loadingError:
                        DataLoadFailedState {
                            viewModel.onEvent(.loadData)
                        }
                    case .defaultError:
                        UnknownErrorState {
                            viewModel.onEvent(.loadData)
                        }
                    default:
                        EmptyView()
                    }
                } else if viewModel.state.isLoading {
                    ProgressView()
                } else if viewModel.state.historyList.isEmpty {
                    NoDataState()
                } else {
                    List(viewModel.state.historyList, id: \.id) { item in
                        HistoryListItemCard(healthData: item)
                            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.onEvent(.loadData)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive) {
                            viewModel.onEvent(.clearHistory)
                        } label: {
                            Label("Clear History", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .alert("Success", isPresented: $showClearedAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("History cleared successfully.")
            }
            .onReceive(viewModel.uiEvents) { event in
                switch event {
                case .historyClearedSuccessfully:
                    showClearedAlert = true
                }
            }
        }
    }
}


#Preview {
    HistoryScreen(historyRepository: MockHistoryRepository())
}
