import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel(
        userDetailsRepository: UserDetailsRepositoryImpl(
            userDetailsService: UserDetailsServiceImpl()
        )
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let error = viewModel.state.homeError {
                    switch error {
                    case .loadingError:
                        DataLoadFailedState {
                            viewModel.onEvent(.loadData)
                        }
                    case .defaultError:
                        UnknownErrorState {
                            viewModel.onEvent(.loadData)
                        }
                    }
                } else if let details = viewModel.state.userDetails {
                    ScrollView {
                        VStack(spacing: 8) {
                            AverageHealthMetricCard(
                                title: "Heart rate",
                                averageValue: details.averageHeartRate,
                                minValue: 40,
                                maxValue: 185,
                                unit: "bpm",
                                icon: Image(.heartRate)
                            )
                            
                            AverageHealthMetricCard(
                                title: "Oxygen saturation",
                                averageValue: details.averageOxygenSaturation,
                                minValue: 80,
                                maxValue: 100,
                                unit: "%",
                                icon: Image(.oxygen)
                            )
                        }
                    }
                } else if viewModel.state.isLoading {
                    ProgressView()
                } else {
                    NoDataState()
                }
            }
            .padding()
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.onEvent(.loadData)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
