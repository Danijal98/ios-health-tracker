import SwiftUI

struct LoaderButton: View {
    let text: String
    var isEnabled: Bool = true
    let isLoading: Bool
    var fullWidth: Bool = false
    let onClick: () -> Void

    var body: some View {
        Button(action: onClick) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: fullWidth ? .infinity : nil)
            } else {
                Text(text)
                    .frame(maxWidth: fullWidth ? .infinity : nil)
            }
        }
        .tint(isLoading ? .red : .blue)
        .buttonStyle(.borderedProminent)
        .disabled(isLoading || !isEnabled)
    }
}

#Preview("Default") {
    LoaderButton(
        text: "Save",
        isEnabled: true,
        isLoading: false,
        fullWidth: false,
        onClick: {}
    )
}

#Preview("Loading") {
    LoaderButton(
        text: "Save",
        isEnabled: false,
        isLoading: true,
        fullWidth: false,
        onClick: {}
    )
}
