import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var showTopText = false
    @State private var showBottomText = false

    var body: some View {
        VStack {
            VStack (spacing: 520) {
                if showTopText {
                    Text("Airlines")
                        .font(Font.custom("Baskerville-Bold", size: 36))
                        .foregroundColor(.black.opacity(0.80))
                }
                if showBottomText {
                    Text("by Klimko")
                        .font(Font.custom("Baskerville-Bold", size: 36))
                        .foregroundColor(.black.opacity(0.80))
                }
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 0.9
                    self.opacity = 1.00
                }
            }
        }
        .onAppear {
            // Анимация появления текста
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeIn(duration: 1)) {
                    self.showTopText = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn(duration: 1)) {
                    self.showBottomText = true
                }
            }

            // Задержка перед переходом к основному экрану
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isActive = true
            }
        }
        // Показ основного экрана, если isActive = true
        .fullScreenCover(isPresented: $isActive) {
            ContentView() // Переход на основной экран
        }
    }
}
