import SwiftUI

struct SearchButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Search")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 5)
                .scaleEffect(1.1)
                .animation(.spring(), value: 1.1)
        }
        .padding(.horizontal, 16)
    }
}
