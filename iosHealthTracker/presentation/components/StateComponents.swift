import SwiftUI


struct ImageWithText<Actions: View>: View {
    let text: String
    let image: Image
    let actions: () -> Actions
    
    init(image: Image, text: String, @ViewBuilder actions: @escaping () -> Actions = { EmptyView() }) {
        self.image = image
        self.text = text
        self.actions = actions
    }
    
    var body: some View {
        VStack(spacing: 16) {
            image
                .resizable()
                .scaledToFit()
            
            Text(text)
                .font(.body)
            
            actions()
        }
    }
}

struct NoDataState: View {
    var body: some View {
        ImageWithText(image: Image(.noData), text: "No data")
    }
}

#Preview("No data") {
    NoDataState()
}

struct DataLoadFailedState: View {
    let retry: () -> Void
    
    var body: some View {
        ImageWithText(image: Image(.loadFailed), text: "Loading failed") {
            Button(action: retry) {
                Text("Retry")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview("Data load failed") {
    DataLoadFailedState(retry: {})
}

struct UnknownErrorState: View {
    let text: String
    let retry: () -> Void
    
    init(text: String = "Unknown error", retry: @escaping () -> Void) {
        self.text = text
        self.retry = retry
    }
    
    var body: some View {
        ImageWithText(image: Image(.unknownError), text: text) {
            Button(action: retry) {
                Text("Retry")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview("Unknown error") {
    UnknownErrorState(text: "Unknown error", retry: {})
}
