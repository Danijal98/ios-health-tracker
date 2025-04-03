import SwiftUI


struct CardView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        content()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
    }
}

#Preview {
    CardView {
        Text("Text")
    }
}
